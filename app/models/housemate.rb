class Housemate < ActiveRecord::Base
  belongs_to :house

  has_many :parts
  has_many :deposits

  attr_accessible :name

  def balance
    amount = 0

    Part.where(:housemate_id => id).each do |part|
      amount -= part.amount
    end

    Deposit.where(:housemate_id => id).each do |part|
      amount += part.amount
    end

    amount
  end

  def transactions
    transactions = []
    deposits.each do |d|
      transactions << { :amount => d.amount, :date => d.date }
    end
    parts.each do |p|
      transactions << { :amount => -p.amount, :date => p.bill.paid }
    end
    transactions.sort_by { |k,v| k[:date] }
  end
end
