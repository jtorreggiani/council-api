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

ActiveRecord::Schema.define(version: 2018_11_17_185944) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "councils", force: :cascade do |t|
    t.text "gss", null: false
    t.text "name", null: false
    t.text "url"
    t.text "snac"
    t.text "ideal_postcodes_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_online", default: false, null: false
    t.index ["gss"], name: "index_councils_on_gss", unique: true
    t.index ["name"], name: "index_councils_on_name", unique: true
  end

  create_table "pings", force: :cascade do |t|
    t.bigint "council_id"
    t.boolean "is_up", null: false
    t.datetime "created_at", null: false
    t.index ["council_id", "created_at", "is_up"], name: "index_pings_on_council_id_and_created_at_and_is_up"
  end

  add_foreign_key "pings", "councils"
end
