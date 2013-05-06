# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121205004924) do

  create_table "bills", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.decimal  "amount",      :precision => 8, :scale => 2
    t.date     "due"
    t.date     "paid"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "house_id"
  end

  create_table "deposits", :force => true do |t|
    t.string   "description"
    t.decimal  "amount",       :precision => 8, :scale => 2
    t.integer  "housemate_id"
    t.date     "date"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  add_index "deposits", ["housemate_id"], :name => "index_deposits_on_housemate_id"

  create_table "housemates", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "house_id"
  end

  create_table "houses", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "parts", :force => true do |t|
    t.string   "description"
    t.decimal  "amount",       :precision => 8, :scale => 2
    t.integer  "bill_id"
    t.integer  "housemate_id"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  add_index "parts", ["bill_id"], :name => "index_parts_on_bill_id"
  add_index "parts", ["housemate_id"], :name => "index_parts_on_housemate_id"

end
