class House
  include Mongoid::Document

  field :name, :type => String
  field :address, :type => String

  has_many :house_mates, :dependent => :destroy
  has_many :billers, :dependent => :destroy
  has_many :bills, :dependent => :destroy

  accepts_nested_attributes_for :house_mates, :allow_destroy => :true, :reject_if => proc { |attrs| attrs.all? { |k,v| v.blank? } }

  def map(xsize,ysize)
    URI.encode("https://maps.googleapis.com/maps/api/staticmap?center="+address+"&zoom=14&size="+xsize+"x"+ysize+"&sensor=false&markers=size:mid|"+address)
  end

  def image(xsize,ysize)
    URI.encode("http://maps.googleapis.com/maps/api/streetview?size="+xsize+"x"+ysize+"&location="+address+"&heading=-90&sensor=false")
  end

  def balance
    amount = 0
    self.bills.where(:paid => true).each do |bill|
      amount -= bill.amount
    end
    self.house_mates.each do |housemate|
      housemate.deposits.each do |deposit|
        amount += deposit.amount
      end
    end
    amount
  end

  def get_house_mate_for(user)
    self.house_mates.where(:user => user) || false
  end
end
