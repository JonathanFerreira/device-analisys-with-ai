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

ActiveRecord::Schema[7.2].define(version: 2025_06_10_215754) do
  create_table "sale_cycles", force: :cascade do |t|
    t.integer "sale_id", null: false
    t.string "imei"
    t.string "step"
    t.string "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["imei"], name: "index_sale_cycles_on_imei"
    t.index ["kind"], name: "index_sale_cycles_on_kind"
    t.index ["sale_id"], name: "index_sale_cycles_on_sale_id"
    t.index ["step"], name: "index_sale_cycles_on_step"
  end

  create_table "sales", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.json "analysis"
    t.datetime "analyzed_at"
    t.string "status"
    t.index ["status"], name: "index_sales_on_status"
  end

  add_foreign_key "sale_cycles", "sales"
end
