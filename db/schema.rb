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

ActiveRecord::Schema.define(version: 20140322000005) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", force: :cascade do |t|
    t.integer  "worker_id"
    t.integer  "customer_id"
    t.string   "description", default: "", null: false
    t.date     "start_date",                    null: false
    t.date     "end_date",                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "jobs", ["customer_id"], name: "index_jobs_on_customer_id", using: :btree
  add_index "jobs", ["end_date"], name: "index_jobs_on_end_date", using: :btree
  add_index "jobs", ["start_date"], name: "index_jobs_on_start_date", using: :btree
  add_index "jobs", ["worker_id"], name: "index_jobs_on_worker_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",               default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "rolable_id"
    t.string   "rolable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["rolable_type", "rolable_id"], name: "index_users_on_rolable_type_and_rolable_id", using: :btree

  create_table "workers", force: :cascade do |t|
    t.string   "name",                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "skills",     default: [],              array: true
  end

  add_index "workers", ["skills"], name: "index_workers_on_skills", using: :gin

end
