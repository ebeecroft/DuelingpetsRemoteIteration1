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

ActiveRecord::Schema.define(version: 2019_07_08_050933) do

  create_table "registrations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.string "country"
    t.string "country_timezone"
    t.date "birthday"
    t.text "message"
    t.integer "accounttype_id"
    t.string "login_id"
    t.string "vname"
    t.datetime "registered_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "webcontrols", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_on"
    t.string "banner"
    t.string "mascot"
    t.string "favicon"
    t.integer "daycolor_id"
    t.integer "nightcolor_id"
    t.string "ogg"
    t.string "mp3"
    t.string "criticalogg"
    t.string "criticalmp3"
    t.string "betaogg"
    t.string "betamp3"
    t.string "grandogg"
    t.string "grandmp3"
    t.string "creationogg"
    t.string "creationmp3"
    t.string "maintenanceogg"
    t.string "maintenancemp3"
    t.boolean "gate_open"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
