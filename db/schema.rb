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

ActiveRecord::Schema.define(version: 2021_09_11_231455) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "corruption_cases", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "slug"
    t.integer "stolen_amount"
    t.text "place"
    t.datetime "trial_start_at"
    t.datetime "sentenced_at"
    t.integer "sentence"
    t.string "european_funds_project"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slug"], name: "index_corruption_cases_on_slug"
  end

end
