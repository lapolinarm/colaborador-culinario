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

ActiveRecord::Schema[7.1].define(version: 2024_09_17_200359) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "job_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_favorites_on_job_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "job_users", force: :cascade do |t|
    t.integer "status"
    t.integer "payment_method_used"
    t.float "amount_paid"
    t.bigint "user_id", null: false
    t.bigint "job_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_job_users_on_job_id"
    t.index ["user_id"], name: "index_job_users_on_user_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.date "date"
    t.time "hour_start"
    t.time "hour_end"
    t.float "payment_hour"
    t.integer "job_type"
    t.integer "job_mode"
    t.integer "function"
    t.text "description"
    t.text "responsibility"
    t.text "requirement"
    t.bigint "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_jobs_on_restaurant_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "ruc"
    t.string "commercial_name"
    t.string "company_name"
    t.string "phone"
    t.string "mobile_phone"
    t.string "address"
    t.string "district"
    t.string "province"
    t.string "country"
    t.text "reference"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_restaurants_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "dni"
    t.string "first_name"
    t.string "last_name"
    t.string "mobile_phone"
    t.integer "role"
    t.string "address"
    t.integer "payment_method"
    t.string "bank"
    t.string "name_holder"
    t.string "bank_account"
    t.string "cci"
    t.string "digital_wallet"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "favorites", "jobs"
  add_foreign_key "favorites", "users"
  add_foreign_key "job_users", "jobs"
  add_foreign_key "job_users", "users"
  add_foreign_key "jobs", "restaurants"
  add_foreign_key "restaurants", "users"
end
