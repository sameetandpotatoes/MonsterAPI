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

ActiveRecord::Schema.define(version: 20140403214503) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "twitters", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.text   "users"
    t.text   "provider"
    t.text   "string"
    t.text   "uid"
    t.text   "name"
    t.text   "oauth_token"
    t.text   "oauth_expires_at"
    t.text   "created_at"
    t.text   "updated_at"
    t.text   "quote"
    t.text   "location"
    t.string "email"
    t.text   "image"
    t.string "e"
    t.text   "github_results",   default: "--- {}\n"
    t.text   "linkedin_results", default: "--- {}\n"
  end

end
