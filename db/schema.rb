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

ActiveRecord::Schema.define(:version => 20130625115412) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.integer  "balance"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "balance_initial"
  end

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.string   "label_class"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "parent_id"
  end

  create_table "transactions", :force => true do |t|
    t.boolean  "income"
    t.string   "description"
    t.integer  "amount"
    t.date     "date"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "account_id"
    t.integer  "contact_id"
    t.integer  "transaction_settlement_id"
    t.integer  "transaction_transfer_id"
    t.integer  "tag_id"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
    t.integer  "transfer_tag_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
