class House < ActiveRecord::Base
  has_many  :housemates
  has_many  :bills
  has_many  :deposits, :through => :housemates

  attr_accessible :address, :description, :name
end
