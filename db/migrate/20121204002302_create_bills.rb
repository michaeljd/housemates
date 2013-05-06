class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :name
      t.string :description
      t.decimal :amount, :precision => 8, :scale => 2
      t.date :due
      t.date :paid

      t.timestamps
    end
  end
end
