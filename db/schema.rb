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

ActiveRecord::Schema.define(version: 20151115100756) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

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

  create_table "listing_filters", force: :cascade do |t|
    t.string   "css_selector"
    t.string   "text"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "listings", force: :cascade do |t|
    t.string   "description"
    t.string   "url"
    t.string   "data_id"
    t.boolean  "hide",        default: false, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.date     "post_date"
  end

  add_index "listings", ["data_id"], name: "index_listings_on_data_id", unique: true, using: :btree

end
