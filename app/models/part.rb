class Part < ActiveRecord::Base
  belongs_to :bill
  belongs_to :housemate

  attr_accessible :amount, :description
end
