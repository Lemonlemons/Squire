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

ActiveRecord::Schema.define(version: 20150625041213) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dukes", force: :cascade do |t|
    t.string   "email",                           default: "",    null: false
    t.string   "encrypted_password",              default: "",    null: false
    t.string   "phonenumber"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "mailingaddress"
    t.string   "mailingcity"
    t.string   "mailingstate"
    t.string   "mailingcountry"
    t.string   "mailingzipcode"
    t.boolean  "is_mailingsameasphysicaladdress", default: true
    t.string   "physicaladdress"
    t.string   "physicalcity"
    t.string   "physicalstate"
    t.string   "physicalcountry"
    t.string   "physicalzipcode"
    t.datetime "birthday"
    t.integer  "rating",                          default: 100
    t.integer  "numberofquests",                  default: 0
    t.integer  "numberofreviews",                 default: 0
    t.boolean  "partiallyregistered",             default: false
    t.boolean  "fullyregistered",                 default: false
    t.string   "customertoken"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "flagsreceived"
    t.integer  "activequests",                    default: 0
  end

  add_index "dukes", ["confirmation_token"], name: "index_dukes_on_confirmation_token", unique: true, using: :btree
  add_index "dukes", ["email"], name: "index_dukes_on_email", unique: true, using: :btree
  add_index "dukes", ["reset_password_token"], name: "index_dukes_on_reset_password_token", unique: true, using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.integer  "quantity",   default: 1
    t.string   "brand"
    t.integer  "daystoship"
    t.string   "size"
    t.integer  "quest_id"
    t.integer  "duke_id"
    t.integer  "squire_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "proofimg"
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "squire_id"
    t.integer  "duke_id"
    t.integer  "quest_id"
    t.integer  "sentby"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notes", force: :cascade do |t|
    t.integer  "rating"
    t.string   "title"
    t.text     "explanation"
    t.integer  "squire_id"
    t.integer  "duke_id"
    t.integer  "quest_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "quests", force: :cascade do |t|
    t.string   "imagesrc"
    t.integer  "submissiontype"
    t.integer  "squire_id"
    t.integer  "duke_id"
    t.boolean  "is_accepted",         default: false
    t.boolean  "is_proposalsent",     default: false
    t.boolean  "is_proposalaccepted", default: false
    t.boolean  "is_proofsubmitted",   default: false
    t.boolean  "is_completed",        default: false
    t.integer  "timesflagged",        default: 0
    t.string   "title"
    t.text     "description"
    t.float    "pricetosquire",       default: 0.0
    t.float    "totalprice",          default: 0.0
    t.float    "squirescut",          default: 0.0
    t.float    "platformfees",        default: 0.0
    t.string   "proof1"
    t.string   "proof2"
    t.string   "proof3"
    t.text     "revision"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "stripetoken"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "rating"
    t.string   "title"
    t.text     "explanation"
    t.integer  "squire_id"
    t.integer  "duke_id"
    t.integer  "quest_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "firstname"
    t.string   "lastname"
    t.string   "phonenumber"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zipcode"
    t.string   "publishable_key"
    t.string   "provider"
    t.string   "uid"
    t.string   "access_code"
    t.datetime "birthday"
    t.boolean  "is_female",              default: false
    t.integer  "activequests",           default: 0
    t.integer  "completedquests",        default: 0
    t.float    "totalcollected",         default: 0.0
    t.boolean  "completedbasictraining", default: false
    t.boolean  "completedquestionairre", default: false
    t.boolean  "completedinterview",     default: false
    t.boolean  "completedstripe",        default: false
    t.boolean  "completedregistration",  default: false
    t.string   "profilepic"
    t.text     "description"
    t.text     "question1"
    t.text     "question2"
    t.text     "question3"
    t.text     "question4"
    t.text     "question5"
    t.integer  "numberofquestsflagged",  default: 0
    t.integer  "numberofreviews",        default: 0
    t.integer  "reviewpercentage",       default: 100
    t.string   "businessname"
    t.integer  "numberofnotes",          default: 0
    t.boolean  "is_admin",               default: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
