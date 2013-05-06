class HouseMateRole
  include Mongoid::Document
  
  has_and_belongs_to_many :house_mates
  belongs_to :resource, :polymorphic => true
  
  field :name, :type => String
  index({ :name => 1 }, { :unique => true })


  index({
    :name => 1,
    :resource_type => 1,
    :resource_id => 1
  },
  { :unique => true})
  
  scopify
end
