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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131021173445) do

  create_table "analisies", force: true do |t|
    t.float    "lowest_rate"
    t.float    "medium_rate"
    t.float    "highest_rate"
    t.string   "algoritms_rate"
    t.integer  "period"
    t.date     "date"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cindices", force: true do |t|
    t.integer "company_id"
    t.integer "index_id"
  end

  create_table "companies", force: true do |t|
    t.string   "shortcut"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "indices", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.text     "content"
    t.boolean  "is_read"
    t.integer  "sender_id"
    t.integer  "reciver_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "temp_analisies", force: true do |t|
    t.float    "lowest_rate"
    t.float    "medium_rate"
    t.float    "highest_rate"
    t.string   "algoritms_rate"
    t.integer  "period"
    t.date     "date"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_analyses", force: true do |t|
    t.float    "rate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password"
    t.string   "password_hash"
    t.string   "registration_hash"
    t.datetime "last_logged_at"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
