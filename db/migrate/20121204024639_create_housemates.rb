class CreateHousemates < ActiveRecord::Migration
  def change
    create_table :housemates do |t|
      t.string :name

      t.timestamps
    end
  end
end
