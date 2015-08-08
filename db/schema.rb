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

ActiveRecord::Schema.define(version: 20150808012616) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "keywords", force: :cascade do |t|
    t.string   "word"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "hide",       default: false, null: false
  end

  create_table "keywords_listings", id: false, force: :cascade do |t|
    t.integer "keyword_id"
    t.integer "listing_id"
  end

  add_index "keywords_listings", ["keyword_id"], name: "index_keywords_listings_on_keyword_id", using: :btree
  add_index "keywords_listings", ["listing_id"], name: "index_keywords_listings_on_listing_id", using: :btree

  create_table "listings", force: :cascade do |t|
    t.string   "description"
    t.string   "url"
    t.string   "data_id"
    t.boolean  "hide",        default: false, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

end
