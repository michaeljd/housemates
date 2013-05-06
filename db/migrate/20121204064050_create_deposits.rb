class CreateDeposits < ActiveRecord::Migration
  def change
    create_table :deposits do |t|
      t.string :description
      t.decimal :amount, :precision => 8, :scale => 2
      t.references :housemate
      t.date :date

      t.timestamps
    end
    add_index :deposits, :housemate_id
  end
end
