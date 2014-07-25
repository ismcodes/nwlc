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

ActiveRecord::Schema.define(version: 20140712012227) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "requests", force: true do |t|
    t.string   "class_name"
    t.string   "topic"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tutorabilities", force: true do |t|
    t.integer  "user_id"
    t.string   "class_name"
    t.integer  "ability"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tutoringsessions", force: true do |t|
    t.integer  "user_id"
    t.integer  "tutor_id"
    t.boolean  "finished"
    t.string   "classname"
    t.string   "topic"
    t.string   "materials"
    t.string   "discussion"
    t.string   "followup"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "image"
    t.boolean  "tutoring"
    t.boolean  "loggedin"
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
