class AddHouseToHousemateBill < ActiveRecord::Migration
  def change
    add_column :housemates, :house_id, :integer
    add_column :bills, :house_id, :integer
  end
end
