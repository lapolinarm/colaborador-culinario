ActiveRecord::Schema[7.1].define(version: 2024_09_11_172519) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  add_foreign_key "favorites", "jobs"
  add_foreign_key "favorites", "users"
  add_foreign_key "job_users", "jobs"
  add_foreign_key "job_users", "users"
  add_foreign_key "jobs", "restaurants"
  add_foreign_key "restaurants", "users"
end
