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

ActiveRecord::Schema.define(version: 20160504180424) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.integer  "summoner_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "summoner_name"
  end

  create_table "champions", force: :cascade do |t|
    t.integer  "champion_id"
    t.integer  "book_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "highest_grade"
    t.integer  "mastery_points"
    t.integer  "mastery_level"
  end

  add_index "champions", ["book_id"], name: "index_champions_on_book_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "text"
    t.string   "signature"
    t.string   "type"
    t.integer  "book_id"
    t.integer  "champion_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
  end

  add_index "comments", ["book_id"], name: "index_comments_on_book_id", using: :btree
  add_index "comments", ["champion_id"], name: "index_comments_on_champion_id", using: :btree

  create_table "static_champions", force: :cascade do |t|
    t.integer  "champion_id"
    t.string   "name"
    t.string   "title"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "profile_url"
    t.string   "splash_url"
  end

  add_index "static_champions", ["champion_id"], name: "index_static_champions_on_champion_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.string   "name"
    t.string   "img_url"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "users", ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true, using: :btree
  add_index "users", ["provider"], name: "index_users_on_provider", using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree

end
