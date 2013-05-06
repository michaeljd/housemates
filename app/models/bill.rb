class Bill
  include Mongoid::Document
  field :name, :type => String
  field :description, :type => String
  field :amount, :type => Float
  field :due, :type => Date
  field :paid, :type => Boolean
  field :paid_date, :type => Date

  belongs_to :house
  has_many :bill_parts, :dependent => :destroy

  accepts_nested_attributes_for :bill_parts

  def total_amount
    amount = 0.00
    self.bill_parts.each do |part|
      amount += part.amount
    end
    amount
  end
end
