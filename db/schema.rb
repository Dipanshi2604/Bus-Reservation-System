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

ActiveRecord::Schema[7.1].define(version: 2024_02_02_060730) do
  create_table "buses", force: :cascade do |t|
    t.string "title"
    t.integer "total_seats"
    t.string "source"
    t.string "destination"
    t.datetime "arrival_time"
    t.datetime "departure_time"
    t.integer "registration_no"
    t.integer "bus_owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bus_owner_id"], name: "index_buses_on_bus_owner_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "bus_id", null: false
    t.integer "seat_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "reservation_date"
    t.index ["bus_id"], name: "index_reservations_on_bus_id"
    t.index ["seat_id"], name: "index_reservations_on_seat_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "seats", force: :cascade do |t|
    t.integer "seat_no"
    t.boolean "seat_status", default: false
    t.integer "bus_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bus_id"], name: "index_seats_on_bus_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "user_type"
    t.string "name"
    t.integer "mobile_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "buses", "users", column: "bus_owner_id"
  add_foreign_key "reservations", "buses"
  add_foreign_key "reservations", "seats"
  add_foreign_key "reservations", "users"
  add_foreign_key "seats", "buses"
end
