class Bill < ActiveRecord::Base
  require 'csv.rb'

  belongs_to :house

  has_many :parts, :dependent => :destroy

  attr_accessible :amount, :description, :due, :name, :paid

  def paid?
    paid.present?
  end

  def self.import(house,upload)
    name = upload['datafile'].original_filename

    num_rows = 0
    num_cols = 0

    keys = {}
    housemates = {}

    CSV.parse(upload['datafile'].read) do |row|
      index = 0

      if num_cols == 0
        # Parse first row
        row.each do |key|
          if key.downcase == 'total'
            keys[:total] = index
          elsif key.downcase == 'date'
            keys[:date] = index
          elsif key.downcase == 'comment'
            keys[:comment] = index
          else
            housemates[key] = { :index => index, :housemate => house.housemates.find_or_create_by_name(key) }
          end
          index += 1
        end


      else
        # Parse rest of rows
        bill = house.bills.create :name => row[keys[:comment]], :amount => row[keys[:total]], :paid => Date.parse(row[keys[:date]])
        housemates.each do |h|
          index = h[1][:index]
          housemate = h[1][:housemate]
          if row[index].present?
            part = Part.new :amount => row[index]
            part.housemate = housemate
            part.bill = bill
            part.save
          end
        end
      end
      num_cols += 1
    end
  end
end
