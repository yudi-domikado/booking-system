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

ActiveRecord::Schema.define(:version => 20130803144411) do

  create_table "cart_room_items", :force => true do |t|
    t.integer  "room_id"
    t.date     "check_in_date"
    t.integer  "start_time"
    t.integer  "end_time"
    t.integer  "room_cart_id"
    t.string   "title"
    t.integer  "price"
    t.decimal  "amount",        :precision => 10, :scale => 0
    t.integer  "quantity"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  create_table "carts", :force => true do |t|
    t.string   "session_id"
    t.string   "type"
    t.decimal  "amount",     :precision => 10, :scale => 0
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "companies", :force => true do |t|
    t.string   "title"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "color"
  end

  create_table "facilities", :force => true do |t|
    t.string   "name"
    t.integer  "price"
    t.integer  "room_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "order_room_items", :force => true do |t|
    t.integer  "room_id"
    t.date     "check_in_date"
    t.integer  "start_time"
    t.integer  "end_time"
    t.integer  "room_order_id"
    t.string   "title"
    t.integer  "price"
    t.decimal  "amount",        :precision => 10, :scale => 0
    t.integer  "quantity"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.string   "status"
  end

  create_table "orders", :force => true do |t|
    t.datetime "order_at"
    t.integer  "user_id"
    t.string   "type"
    t.string   "status"
    t.decimal  "amount",      :precision => 10, :scale => 0
    t.text     "message"
    t.string   "code"
    t.integer  "code_number"
    t.string   "slug"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  add_index "orders", ["code"], :name => "index_orders_on_code", :unique => true
  add_index "orders", ["code_number"], :name => "index_orders_on_code_number"
  add_index "orders", ["slug"], :name => "index_orders_on_slug", :unique => true
  add_index "orders", ["type"], :name => "index_orders_on_type"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rooms", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.decimal  "price",                :precision => 10, :scale => 0, :default => 0
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "slug"
    t.datetime "created_at",                                                         :null => false
    t.datetime "updated_at",                                                         :null => false
  end

  add_index "rooms", ["slug"], :name => "index_rooms_on_slug", :unique => true

  create_table "users", :force => true do |t|
    t.string   "username",               :default => "", :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "role_id"
    t.string   "name"
    t.integer  "company_id"
    t.string   "department"
    t.string   "phone"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["role_id"], :name => "index_users_on_role_id"

end
