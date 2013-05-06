class Biller
  include Mongoid::Document
  field :name, :type => String
  field :description, :type => String
  field :website, :type => String

  belongs_to :house
end
