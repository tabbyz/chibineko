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

ActiveRecord::Schema.define(version: 20160319072222) do

  create_table "projects", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "projects", ["name", "team_id"], name: "index_projects_on_name_and_team_id", unique: true
  add_index "projects", ["name"], name: "index_projects_on_name"

  create_table "team_users", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "team_users", ["team_id", "user_id"], name: "index_team_users_on_team_id_and_user_id", unique: true
  add_index "team_users", ["team_id"], name: "index_team_users_on_team_id"
  add_index "team_users", ["user_id"], name: "index_team_users_on_user_id"

  create_table "teams", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "teams", ["name"], name: "index_teams_on_name"

  create_table "testcases", force: :cascade do |t|
    t.integer  "heading_level"
    t.text     "body"
    t.string   "result"
    t.text     "note"
    t.integer  "test_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "testcases", ["result", "test_id"], name: "index_testcases_on_result_and_test_id"

  create_table "tests", force: :cascade do |t|
    t.string   "slug",          null: false
    t.string   "title"
    t.text     "description"
    t.text     "result_labels"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "tests", ["created_at"], name: "index_tests_on_created_at"
  add_index "tests", ["slug"], name: "index_tests_on_slug"
  add_index "tests", ["updated_at"], name: "index_tests_on_updated_at"

  create_table "users", force: :cascade do |t|
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username"
    t.string   "timezone"
    t.string   "locale"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
