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

ActiveRecord::Schema.define(version: 20131208062104) do

  create_table "deadlines", force: true do |t|
    t.integer  "members_id"
    t.integer  "projects_id"
    t.text     "description"
    t.datetime "due_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "deadlines", ["members_id"], name: "index_deadlines_on_members_id", using: :btree
  add_index "deadlines", ["projects_id"], name: "index_deadlines_on_projects_id", using: :btree

  create_table "managers", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.datetime "expected_due_date"
    t.integer  "manager_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["manager_id"], name: "index_projects_on_manager_id", using: :btree

end
