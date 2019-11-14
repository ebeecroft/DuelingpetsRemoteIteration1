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

ActiveRecord::Schema.define(version: 2019_11_06_040905) do

  create_table "accounttypes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artpages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "message"
    t.datetime "created_on"
    t.string "art"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blacklisteddomains", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_on"
    t.boolean "domain_only", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blacklistednames", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blogs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "ogg"
    t.string "mp3"
    t.string "adbanner"
    t.string "admascot"
    t.string "largeimage1"
    t.string "largeimage2"
    t.string "largeimage3"
    t.string "smallimage1"
    t.string "smallimage2"
    t.string "smallimage3"
    t.string "smallimage4"
    t.string "smallimage5"
    t.datetime "created_on"
    t.datetime "reviewed_on"
    t.datetime "updated_on"
    t.integer "blogtype_id"
    t.integer "bookgroup_id"
    t.integer "blogviewer_id"
    t.integer "user_id"
    t.boolean "largeimage1purchased", default: false
    t.boolean "largeimage2purchased", default: false
    t.boolean "largeimage3purchased", default: false
    t.boolean "smallimage1purchased", default: false
    t.boolean "smallimage2purchased", default: false
    t.boolean "smallimage3purchased", default: false
    t.boolean "smallimage4purchased", default: false
    t.boolean "smallimage5purchased", default: false
    t.boolean "musicpurchased", default: false
    t.boolean "adbannerpurchased", default: false
    t.boolean "pointsreceived", default: false
    t.boolean "reviewed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blogtypes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blogviewers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookgroups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "colorschemes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "colortype"
    t.text "description"
    t.datetime "created_on"
    t.integer "user_id"
    t.boolean "activated", default: false
    t.boolean "democolor", default: false
    t.string "backgroundcolor"
    t.string "headercolor"
    t.string "textcolor"
    t.string "defaultbuttoncolor"
    t.string "defaultbuttonbackgcolor"
    t.string "editbuttoncolor"
    t.string "editbuttonbackgcolor"
    t.string "destroybuttoncolor"
    t.string "destroybuttonbackgcolor"
    t.string "submitbuttoncolor"
    t.string "submitbuttonbackgcolor"
    t.string "navigationcolor"
    t.string "navigationlinkcolor"
    t.string "navigationhovercolor"
    t.string "navigationhoverbackgcolor"
    t.string "onlinestatuscolor"
    t.string "profilecolor"
    t.string "profilevisitedcolor"
    t.string "profilehovercolor"
    t.string "profilehoverbackgcolor"
    t.string "sessioncolor"
    t.string "navlinkcolor"
    t.string "navlinkhovercolor"
    t.string "navlinkhoverbackgcolor"
    t.string "explanationborder"
    t.string "explanationbackgcolor"
    t.string "explanheadercolor"
    t.string "explanheaderbackgcolor"
    t.string "errorfieldcolor"
    t.string "errorcolor"
    t.string "warningcolor"
    t.string "notificationcolor"
    t.string "successcolor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "difficulties", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "pointdebt", default: 0
    t.integer "pointloan", default: 0
    t.integer "emeralddebt", default: 0
    t.integer "emeraldloan", default: 0
    t.datetime "created_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dragonhoards", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "message"
    t.datetime "created_on"
    t.string "ogg"
    t.string "mp3"
    t.float "taxbase", limit: 53
    t.float "taxinc", limit: 53
    t.integer "ocpoints"
    t.integer "colorschemepoints"
    t.integer "colorschemecleanup"
    t.integer "treasury", default: 0
    t.integer "contestpoints", default: 0
    t.integer "conversioncost"
    t.integer "emeraldvalue"
    t.float "emeraldrate", limit: 53
    t.integer "pointscreated"
    t.integer "profit", default: 0
    t.boolean "denholiday", default: false
    t.string "dragonimage"
    t.integer "blogadbannercost"
    t.integer "bloglargeimagecost"
    t.integer "blogsmallimagecost"
    t.integer "blogmusiccost"
    t.integer "blogpoints"
    t.integer "blogmascotpoints"
    t.integer "dreyterrium_start"
    t.integer "newdreyterriumcapacity"
    t.integer "dreyterrium_extracted", default: 0
    t.integer "dreyterriumchange"
    t.integer "dreyterriumbasepoints"
    t.integer "dreyterriumcurrent_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "economies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "econtype"
    t.string "content_type"
    t.integer "amount"
    t.datetime "created_on"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gameinfos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "difficulty_id"
    t.boolean "lives_enabled", default: false
    t.boolean "ageing_enabled", default: false
    t.datetime "activated_on"
    t.boolean "startgame", default: false
    t.boolean "gamecompleted", default: false
    t.integer "success", default: 0
    t.integer "failure", default: 0
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "itemart"
    t.integer "hp"
    t.integer "atk"
    t.integer "def"
    t.integer "spd"
    t.integer "fun"
    t.integer "hunger"
    t.integer "knowledge"
    t.integer "durability"
    t.integer "rarity"
    t.boolean "starter"
    t.boolean "equipable"
    t.integer "cost"
    t.datetime "created_on"
    t.datetime "reviewed_on"
    t.datetime "updated_on"
    t.integer "user_id"
    t.integer "itemtype_id"
    t.boolean "reviewed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "itemtypes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_on"
    t.integer "basecost"
    t.integer "dreyterriumcost"
    t.boolean "demoitem", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "maintenancemodes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_on"
    t.boolean "maintenance_on", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ocs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "nickname"
    t.string "species"
    t.integer "age"
    t.text "personality"
    t.text "likesanddislikes"
    t.text "backgroundandhistory"
    t.text "relatives"
    t.text "family"
    t.text "friends"
    t.text "world"
    t.string "alignment"
    t.text "alliance"
    t.text "elements"
    t.text "appearance"
    t.text "clothing"
    t.text "accessories"
    t.string "image"
    t.string "ogg"
    t.string "mp3"
    t.string "voiceogg"
    t.string "voicemp3"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.datetime "reviewed_on"
    t.boolean "reviewed", default: false
    t.boolean "pointsreceived", default: false
    t.integer "user_id"
    t.integer "bookgroup_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pouches", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.string "privilege", default: "User"
    t.boolean "admin", default: false
    t.boolean "demouser", default: false
    t.boolean "banned", default: false
    t.string "remember_token"
    t.datetime "expiretime"
    t.boolean "activated", default: false
    t.datetime "signed_in_at"
    t.datetime "last_visited"
    t.datetime "signed_out_at"
    t.boolean "gone", default: false
    t.integer "amount", default: 0
    t.integer "emeraldamount", default: 0
    t.integer "dreyterriumamount", default: 0
    t.integer "pouchlevel", default: 0
    t.integer "oclevel", default: 0
    t.integer "bloglevel", default: 0
    t.integer "emeraldlevel", default: 0
    t.integer "dreyterriumlevel", default: 0
    t.boolean "firstdreyterrium", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "registrations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.string "country"
    t.string "country_timezone"
    t.date "birthday"
    t.text "message"
    t.integer "accounttype_id"
    t.boolean "shared", default: false
    t.string "login_id"
    t.string "vname"
    t.datetime "registered_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shoutboxes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "capacity"
    t.boolean "box_open", default: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shouts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "message"
    t.datetime "created_on"
    t.datetime "reviewed_on"
    t.integer "user_id"
    t.integer "shoutbox_id"
    t.boolean "reviewed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suspendedtimelimits", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "pointfines", default: 0
    t.integer "emeraldfines", default: 0
    t.datetime "timelimit"
    t.text "reason"
    t.datetime "created_on"
    t.integer "user_id"
    t.integer "from_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "userinfos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "avatar"
    t.string "miniavatar"
    t.string "mp3"
    t.string "ogg"
    t.boolean "music_on", default: false
    t.boolean "mute_on", default: false
    t.string "audiobrowser", default: "ogg"
    t.string "videobrowser", default: "ogv"
    t.boolean "militarytime", default: false
    t.integer "bookgroup_id"
    t.text "info"
    t.integer "user_id"
    t.integer "daycolor_id"
    t.integer "nightcolor_id"
    t.boolean "admincontrols_on", default: false
    t.boolean "reviewercontrols_on", default: false
    t.boolean "keymastercontrols_on", default: false
    t.boolean "managercontrols_on", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.string "country"
    t.string "country_timezone"
    t.date "birthday"
    t.string "login_id"
    t.string "vname"
    t.integer "accounttype_id"
    t.boolean "shared", default: false
    t.datetime "joined_on"
    t.datetime "registered_on"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "userupgrades", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "pouchbase"
    t.integer "pouchinc"
    t.integer "pouchcost"
    t.integer "pouchmax"
    t.integer "emeraldbase"
    t.integer "emeraldinc"
    t.integer "emeraldcost"
    t.integer "emeraldmax"
    t.integer "ocbase"
    t.integer "ocinc"
    t.integer "occost"
    t.integer "ocmax"
    t.integer "blogbase"
    t.integer "bloginc"
    t.integer "blogcost"
    t.integer "blogmax"
    t.integer "dreyterriumbase"
    t.integer "dreyterriuminc"
    t.integer "dreyterriumcost"
    t.integer "dreyterriummax"
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
    t.string "missingpageogg"
    t.string "missingpagemp3"
    t.boolean "gate_open", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
