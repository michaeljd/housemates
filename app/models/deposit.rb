class Deposit < ActiveRecord::Base
  require 'csv.rb'
  belongs_to :housemate
  attr_accessible :amount, :date, :description

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
          if key.downcase == 'date'
            keys[:date] = index
          else
            housemates[key] = { :index => index, :housemate => house.housemates.find_or_create_by_name(key) }
          end
          index += 1
        end


      else
        # Parse rest of rows
        housemates.each do |h|
          index = h[1][:index]
          housemate = h[1][:housemate]
          date_row = keys[:date]
          if row[index].present?
            deposit = Deposit.new :amount => row[index], :date => Date.parse(row[date_row])
            deposit.housemate = housemate
            deposit.save
          end
        end
      end
      num_cols += 1
    end
  end
end
