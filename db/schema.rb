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

ActiveRecord::Schema.define(version: 20131124212323) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignments", force: true do |t|
    t.integer  "course_id"
    t.string   "title"
    t.text     "description"
    t.string   "github_login"
    t.string   "github_repo"
    t.datetime "due_date"
    t.string   "assignment_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contributions", force: true do |t|
    t.boolean  "finished"
    t.string   "repo_fork"
    t.string   "travis_data"
    t.integer  "assignment_id"
    t.integer  "user_id"
    t.string   "url"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "github_id"
    t.string   "travis_url"
  end

  add_index "contributions", ["assignment_id"], name: "index_contributions_on_assignment_id", using: :btree
  add_index "contributions", ["user_id"], name: "index_contributions_on_user_id", using: :btree

  create_table "course_memberships", force: true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_memberships", ["course_id"], name: "index_course_memberships_on_course_id", using: :btree
  add_index "course_memberships", ["user_id"], name: "index_course_memberships_on_user_id", using: :btree

  create_table "courses", force: true do |t|
    t.string   "name"
    t.string   "location"
    t.string   "session"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "one_on_ones", force: true do |t|
    t.integer  "student_id"
    t.integer  "teacher_id"
    t.datetime "date"
    t.text     "notes"
    t.text     "student_concerns"
    t.text     "teacher_concerns"
    t.integer  "course_id"
  end

  add_index "one_on_ones", ["course_id"], name: "index_one_on_ones_on_course_id", using: :btree
  add_index "one_on_ones", ["student_id"], name: "index_one_on_ones_on_student_id", using: :btree
  add_index "one_on_ones", ["teacher_id"], name: "index_one_on_ones_on_teacher_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "is_admin",                default: false
    t.string   "telephone"
    t.string   "email"
    t.text     "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "emergency_contact"
    t.string   "emergency_contact_phone"
    t.string   "github_url"
    t.string   "html_url"
    t.string   "repos_url"
    t.string   "gists_url"
    t.string   "avatar_url"
    t.integer  "public_repos"
    t.integer  "followers"
    t.integer  "following"
    t.integer  "github_id"
    t.string   "github_login"
    t.integer  "gravatar_id"
    t.string   "followers_url"
    t.string   "following_url"
    t.string   "starred_url"
    t.string   "subscriptions_url"
    t.string   "organizations_url"
    t.string   "events_url"
    t.string   "received_events_url"
    t.string   "type"
    t.string   "site_admin"
    t.string   "public_gists"
    t.datetime "created_github_profile"
    t.datetime "last_updated_github_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "biography"
    t.string   "encrypted_password",      default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.integer  "absences",                default: 0
    t.integer  "tardies",                 default: 0
    t.integer  "excused_absences",        default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
