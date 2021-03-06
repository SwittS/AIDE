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

ActiveRecord::Schema.define(version: 20160831210053) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "caregiver_specialties", force: :cascade do |t|
    t.integer  "specialty_id"
    t.integer  "caregiver_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["caregiver_id"], name: "index_caregiver_specialties_on_caregiver_id", using: :btree
    t.index ["specialty_id"], name: "index_caregiver_specialties_on_specialty_id", using: :btree
  end

  create_table "caregivers", force: :cascade do |t|
    t.text     "experience"
    t.string   "location"
    t.string   "credentials"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "file"
    t.index ["user_id"], name: "index_caregivers_on_user_id", using: :btree
  end

  create_table "patients", force: :cascade do |t|
    t.string   "location"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "bio"
    t.date     "date_of_birth"
    t.text     "file"
    t.index ["user_id"], name: "index_patients_on_user_id", using: :btree
  end

  create_table "specialties", force: :cascade do |t|
    t.string   "skill"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
    t.index ["slug"], name: "index_specialties_on_slug", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "patient"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "caregiver_specialties", "caregivers"
  add_foreign_key "caregiver_specialties", "specialties"
  add_foreign_key "caregivers", "users"
  add_foreign_key "patients", "users"
end
