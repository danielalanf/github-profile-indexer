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

ActiveRecord::Schema[7.2].define(version: 2025_02_12_141810) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bitlinks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "short_url"
    t.string "long_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["long_url"], name: "index_bitlinks_on_long_url", unique: true
    t.index ["user_id"], name: "index_bitlinks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "github_url", null: false
    t.string "nickname", limit: 50
    t.integer "followers", default: 0
    t.integer "following", default: 0
    t.integer "stars", default: 0
    t.integer "last_year_contributions", default: 0
    t.string "image_url"
    t.string "organization"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
