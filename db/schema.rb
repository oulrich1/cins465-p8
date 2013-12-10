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

ActiveRecord::Schema.define(version: 20131210082922) do

  create_table "deadlines", force: true do |t|
    t.integer  "m_id"
    t.integer  "p_id"
    t.text     "title"
    t.text     "description"
    t.datetime "due_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "managers", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "member_deadline_groupings", force: true do |t|
    t.integer  "m_id"
    t.integer  "d_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "member_project_groupings", force: true do |t|
    t.integer  "m_id"
    t.integer  "p_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", force: true do |t|
    t.string   "name",                   default: "", null: false
    t.string   "type",                   default: "", null: false
    t.string   "is_project_manager",     default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "members", ["email"], name: "index_members_on_email", unique: true, using: :btree
  add_index "members", ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true, using: :btree

  create_table "projects", force: true do |t|
    t.string   "name",              default: "",  null: false
    t.string   "url",               default: "#", null: false
    t.datetime "expected_due_date"
    t.integer  "manager_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["manager_id"], name: "index_projects_on_manager_id", using: :btree

end
