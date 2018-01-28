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

ActiveRecord::Schema.define(version: 20171214040538) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "car_colors", force: :cascade do |t|
    t.bigint "car_trim_id"
    t.string "exterior_color"
    t.string "interior_color"
    t.index ["car_trim_id"], name: "index_car_colors_on_car_trim_id"
  end

  create_table "car_makes", force: :cascade do |t|
    t.bigint "car_year_id"
    t.string "name"
    t.index ["car_year_id"], name: "index_car_makes_on_car_year_id"
  end

  create_table "car_models", force: :cascade do |t|
    t.bigint "car_make_id"
    t.string "name"
    t.index ["car_make_id"], name: "index_car_models_on_car_make_id"
  end

  create_table "car_qualities", force: :cascade do |t|
    t.string "quality"
  end

  create_table "car_trims", force: :cascade do |t|
    t.bigint "car_model_id"
    t.string "trim"
    t.index ["car_model_id"], name: "index_car_trims_on_car_model_id"
  end

  create_table "car_years", force: :cascade do |t|
    t.string "year"
  end

  create_table "contact_preferences", force: :cascade do |t|
    t.string "preference"
  end

  create_table "dealerships", force: :cascade do |t|
    t.string "name"
    t.bigint "car_make_id"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.string "country"
    t.float "latitude"
    t.float "longitude"
    t.index ["car_make_id"], name: "index_dealerships_on_car_make_id"
  end

  create_table "industries", force: :cascade do |t|
    t.string "name"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "recipient_id"
    t.string "action"
    t.string "notifiable_type"
    t.integer "notifiable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "proposals", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "purchase_option_id"
    t.bigint "car_quality_id"
    t.bigint "car_year_id"
    t.bigint "car_make_id"
    t.bigint "car_model_id"
    t.bigint "car_trim_id"
    t.bigint "car_color_id"
    t.text "add_ons"
    t.integer "price"
    t.integer "over_under_price"
    t.integer "down_payment"
    t.integer "lease_length"
    t.integer "mileage_limit"
    t.integer "closing_cost"
    t.boolean "financing"
    t.float "apr"
    t.datetime "deadline"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.string "country"
    t.float "latitude"
    t.float "longitude"
    t.string "radius_limit"
    t.index ["car_color_id"], name: "index_proposals_on_car_color_id"
    t.index ["car_make_id"], name: "index_proposals_on_car_make_id"
    t.index ["car_model_id"], name: "index_proposals_on_car_model_id"
    t.index ["car_quality_id"], name: "index_proposals_on_car_quality_id"
    t.index ["car_trim_id"], name: "index_proposals_on_car_trim_id"
    t.index ["car_year_id"], name: "index_proposals_on_car_year_id"
    t.index ["purchase_option_id"], name: "index_proposals_on_purchase_option_id"
    t.index ["user_id"], name: "index_proposals_on_user_id"
  end

  create_table "purchase_options", force: :cascade do |t|
    t.string "option"
  end

  create_table "responses", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "proposal_id"
    t.bigint "purchase_option_id"
    t.bigint "car_quality_id"
    t.bigint "car_year_id"
    t.bigint "car_make_id"
    t.bigint "car_model_id"
    t.bigint "car_trim_id"
    t.bigint "car_color_id"
    t.text "add_ons"
    t.integer "price"
    t.integer "over_under_price"
    t.integer "down_payment"
    t.integer "lease_length"
    t.integer "mileage_limit"
    t.integer "closing_cost"
    t.boolean "financing"
    t.float "apr"
    t.datetime "deadline"
    t.boolean "hidden_by_user"
    t.boolean "hidden_by_dealer"
    t.index ["car_color_id"], name: "index_responses_on_car_color_id"
    t.index ["car_make_id"], name: "index_responses_on_car_make_id"
    t.index ["car_model_id"], name: "index_responses_on_car_model_id"
    t.index ["car_quality_id"], name: "index_responses_on_car_quality_id"
    t.index ["car_trim_id"], name: "index_responses_on_car_trim_id"
    t.index ["car_year_id"], name: "index_responses_on_car_year_id"
    t.index ["proposal_id"], name: "index_responses_on_proposal_id"
    t.index ["purchase_option_id"], name: "index_responses_on_purchase_option_id"
    t.index ["user_id"], name: "index_responses_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "buyer_id"
    t.bigint "seller_id"
    t.bigint "proposal_id"
    t.bigint "response_id"
    t.string "review"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buyer_id"], name: "index_reviews_on_buyer_id"
    t.index ["proposal_id"], name: "index_reviews_on_proposal_id"
    t.index ["response_id"], name: "index_reviews_on_response_id"
    t.index ["seller_id"], name: "index_reviews_on_seller_id"
  end

  create_table "users", force: :cascade do |t|
    t.boolean "admin", default: false
    t.string "first_name"
    t.string "last_name"
    t.string "email", default: "", null: false
    t.string "phone_number"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.string "country"
    t.float "latitude"
    t.float "longitude"
    t.string "image"
    t.string "credit_score"
    t.boolean "is_dealer"
    t.bigint "dealership_id"
    t.bigint "contact_preference_id"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["contact_preference_id"], name: "index_users_on_contact_preference_id"
    t.index ["dealership_id"], name: "index_users_on_dealership_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "car_colors", "car_trims"
  add_foreign_key "car_makes", "car_years"
  add_foreign_key "car_models", "car_makes"
  add_foreign_key "car_trims", "car_models"
  add_foreign_key "dealerships", "car_makes"
  add_foreign_key "notifications", "users"
  add_foreign_key "proposals", "car_colors"
  add_foreign_key "proposals", "car_makes"
  add_foreign_key "proposals", "car_models"
  add_foreign_key "proposals", "car_qualities"
  add_foreign_key "proposals", "car_trims"
  add_foreign_key "proposals", "car_years"
  add_foreign_key "proposals", "purchase_options"
  add_foreign_key "proposals", "users"
  add_foreign_key "responses", "car_colors"
  add_foreign_key "responses", "car_makes"
  add_foreign_key "responses", "car_models"
  add_foreign_key "responses", "car_qualities"
  add_foreign_key "responses", "car_trims"
  add_foreign_key "responses", "car_years"
  add_foreign_key "responses", "proposals"
  add_foreign_key "responses", "purchase_options"
  add_foreign_key "responses", "users"
  add_foreign_key "reviews", "proposals"
  add_foreign_key "reviews", "responses"
  add_foreign_key "users", "contact_preferences"
  add_foreign_key "users", "dealerships"
end
