class Deposit
  include Mongoid::Document
  field :amount, :type => Float
  field :date, :type => Date

  belongs_to :house_mate
end
