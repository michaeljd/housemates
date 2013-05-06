class HouseMate
  include Mongoid::Document
  rolify :role_cname => 'HouseMateRole'

  belongs_to :user
  belongs_to :house

  has_many :bill_parts, :dependent => :destroy
  has_many :deposits, :dependent => :destroy

  HistoryItem = Struct.new(:date, :amount, :description)

  def name
    HouseMate.where(:house_id => self.house_id).each do |hm|
      if not hm == self and hm.user.first_name == self.user.first_name
        return self.user.first_name + " " + self.user.last_name
      end
    end

    self.user.first_name
  end

  def balance
    total = 0
    self.deposits.each do |deposit|
      total += deposit.amount
    end
    self.bill_parts.each do |bp|
      total -= bp.amount if bp.bill.paid
    end
    total
  end

  def history
    history = Array.new
    self.bill_parts.each do |billpart|
      history << HistoryItem.new(billpart.bill.due, -billpart.amount, billpart.bill.description) if billpart.bill.paid
    end
    self.deposits.each do |deposit|
      history << HistoryItem.new(deposit.date, deposit.amount, "Deposit")
    end
    history.sort {|a,b| b.date <=> a.date }
  end

end
