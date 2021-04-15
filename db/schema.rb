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

ActiveRecord::Schema.define(version: 2021_04_11_104701) do

  create_table "api_keys", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "access_token"
    t.datetime "expire_at"
    t.bigint "oauth_id"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["oauth_id"], name: "index_api_keys_on_oauth_id"
  end

  create_table "authentications", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.bigint "oauth_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["oauth_id"], name: "index_authentications_on_oauth_id"
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
  end

  create_table "oauths", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest"
    t.string "account_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_oauths_on_email", unique: true
  end

end
