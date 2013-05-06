class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.string :description
      t.decimal :amount, :precision => 8, :scale => 2
      t.references :bill
      t.references :housemate

      t.timestamps
    end
    add_index :parts, :bill_id
    add_index :parts, :housemate_id
  end
end
