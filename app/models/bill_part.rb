class BillPart
  include Mongoid::Document

  belongs_to :bill
  belongs_to :house_mate

  field :amount, :type => Float
end
