# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_26_172021) do

  create_table "client_companies", force: :cascade do |t|
    t.string "name"
    t.string "state"
    t.string "city"
    t.integer "zip_code"
    t.string "address"
    t.string "industry"
    t.integer "discount"
    t.string "details"
    t.integer "user_company_id"
    t.integer "client_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "slugged_name"
    t.string "email"
    t.string "details"
    t.string "job_title"
  end

  create_table "jobs", force: :cascade do |t|
    t.integer "owner_id"
    t.integer "user_company_id"
    t.integer "client_company_id"
    t.integer "client_id"
    t.string "end_user"
    t.string "title"
    t.string "details"
  end

  create_table "notes", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "user_company"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.datetime "time"
    t.integer "user_id"
    t.integer "user_company_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "deadline"
    t.boolean "complete"
    t.integer "user_company"
  end

  create_table "user_companies", force: :cascade do |t|
    t.string "name"
    t.string "state"
    t.string "city"
    t.integer "zip_code"
    t.string "address"
    t.string "industry"
    t.integer "user_id"
  end

  create_table "user_job_titles", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.integer "user_company_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "slugged_username"
    t.string "email"
    t.string "password_digest"
  end

end
