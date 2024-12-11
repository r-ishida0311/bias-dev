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

ActiveRecord::Schema[7.1].define(version: 2024_12_11_142329) do
  create_table "ApplyDataTab", id: false, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "apply_data_id", default: 0, null: false
    t.integer "year"
    t.string "reference_no", limit: 10, collation: "utf8mb3_general_ci"
    t.integer "apply_kind"
    t.string "item_name", limit: 60, collation: "utf8mb3_general_ci"
    t.string "apply_emp_no", limit: 8, collation: "utf8mb3_general_ci"
    t.string "proxy_emp_no", limit: 8, collation: "utf8mb3_general_ci"
    t.string "apply_emp_name", limit: 20, collation: "utf8mb3_general_ci"
    t.string "proxy_emp_name", limit: 20, collation: "utf8mb3_general_ci"
    t.string "proxy_op", limit: 20, collation: "utf8mb3_general_ci"
    t.string "apply_emp_dep", limit: 25, collation: "utf8mb3_general_ci"
    t.integer "apply_status"
    t.integer "tech_status", default: 0
    t.string "tech_check_name", limit: 20, collation: "utf8mb3_general_ci"
    t.integer "approve_status"
    t.integer "input_step"
    t.integer "append_file_status", default: 0
    t.integer "boss_check_1", default: 0
    t.string "boss_check_1_name", limit: 20, collation: "utf8mb3_general_ci"
    t.integer "boss_check_2", default: 0
    t.string "boss_check_2_name", limit: 20, collation: "utf8mb3_general_ci"
    t.integer "boss_check_3", default: 0
    t.string "boss_check_3_name", limit: 20, collation: "utf8mb3_general_ci"
    t.integer "boss_check_4"
    t.string "boss_check_4_name", limit: 20, collation: "utf8mb3_general_ci"
    t.string "equipment_name", limit: 20, collation: "utf8mb3_general_ci"
    t.string "manufacturer_name", limit: 40, collation: "utf8mb3_general_ci"
    t.string "supplier_name", limit: 40, collation: "utf8mb3_general_ci"
    t.string "quantity", limit: 4, collation: "utf8mb3_general_ci"
    t.integer "estimated_cost"
    t.string "location", limit: 20, collation: "utf8mb3_general_ci"
    t.string "desired_delivery", limit: 10, collation: "utf8mb3_general_ci"
    t.string "category", limit: 10, collation: "utf8mb3_general_ci"
    t.string "division", limit: 50, collation: "utf8mb3_general_ci"
    t.string "reason", limit: 100, collation: "utf8mb3_general_ci"
    t.string "specific_contents", limit: 2500, collation: "utf8mb3_general_ci"
    t.string "old_asset_no", limit: 20, collation: "utf8mb3_general_ci"
    t.integer "old_asset_multi", default: 0
    t.string "old_asset_YM", limit: 10, collation: "utf8mb3_general_ci"
    t.integer "old_asset_cost"
    t.string "old_asset_handling", limit: 100, collation: "utf8mb3_general_ci"
    t.string "wg_comment", limit: 1024, collation: "utf8mb3_general_ci"
    t.integer "wg_comment_status", default: 0
    t.string "wg_reply_comment", limit: 1024, collation: "utf8mb3_general_ci"
    t.integer "sk_approve_cost"
    t.string "sk_comment", limit: 256, collation: "utf8mb3_general_ci"
    t.datetime "create_date", precision: nil
    t.datetime "update_date", precision: nil
    t.datetime "apply_update_date", precision: nil
    t.datetime "tech_update_date", precision: nil
    t.datetime "boss_update_date", precision: nil
    t.datetime "approve_update_date", precision: nil
    t.datetime "wg_comment_update_date", precision: nil
    t.datetime "wg_reply_comment_update_date", precision: nil
  end

  create_table "DepTab", primary_key: "dep_id", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.integer "year"
    t.string "dep_name", limit: 25, null: false
    t.string "reference_header", limit: 4
    t.string "boss1", limit: 128
    t.string "boss2", limit: 128
    t.string "boss3", limit: 128
    t.string "boss4", limit: 128
    t.integer "dep_order", default: 999, null: false
    t.datetime "create_date", precision: nil
    t.datetime "update_date", precision: nil
    t.index ["year"], name: "fk_rails_2a8d7b1a47"
  end

  create_table "FilesTab", primary_key: "file_id", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.integer "apply_data_id", null: false
    t.integer "year", null: false
    t.string "file_title", limit: 256
    t.integer "file_kind", null: false
    t.string "file_path", limit: 512, null: false
    t.integer "file_order", default: 99, null: false
    t.datetime "upload_date", precision: nil
    t.datetime "update_date", precision: nil
  end

  create_table "add_deps", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "year_id", null: false
    t.string "add_dep"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["year_id"], name: "index_add_deps_on_year_id"
  end

  create_table "applies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "department_id", null: false
    t.bigint "add_dep_id"
    t.string "reference_no"
    t.integer "apply_kind"
    t.string "item_name"
    t.string "apply_emp_no"
    t.string "apply_emp_name"
    t.integer "apply_status"
    t.integer "tech_status"
    t.string "tech_check_name"
    t.integer "approve_status"
    t.string "equipment_name"
    t.string "manufacturer_name"
    t.string "supplier_name"
    t.string "quantity"
    t.integer "estimated_cost"
    t.string "location"
    t.date "desired_delivery"
    t.string "category"
    t.bigint "division_id"
    t.string "reason"
    t.string "specific_contents"
    t.string "old_asset_no"
    t.integer "old_asset_multi"
    t.date "old_asset_YM"
    t.string "old_asset_handling"
    t.string "wg_comment"
    t.integer "wg_comment_status"
    t.string "wg_reply_comment"
    t.integer "sk_approve_cost"
    t.string "sk_comment"
    t.datetime "apply_update_date"
    t.datetime "tech_update_date"
    t.datetime "boss_update_date"
    t.datetime "approve_update_date"
    t.datetime "wg_comment_update_date"
    t.datetime "wg_reply_comment_update_date"
    t.integer "old_asset_cost"
    t.integer "boss1_id"
    t.integer "year"
    t.index ["add_dep_id"], name: "index_applies_on_add_dep_id"
    t.index ["boss1_id"], name: "fk_rails_2b516931c6"
    t.index ["department_id"], name: "index_applies_on_department_id"
    t.index ["division_id"], name: "fk_rails_0d9501c942"
  end

  create_table "apply_data_tabs_old", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "year"
    t.string "reference_no"
    t.integer "apply_kind"
    t.string "item_name"
    t.string "apply_emp_no"
    t.string "proxy_emp_no"
    t.string "apply_emp_name"
    t.string "proxy_emp_name"
    t.string "prox_op"
    t.string "apply_emp_dep"
    t.integer "apply_status"
    t.integer "tech_status"
    t.string "tech_check_name"
    t.integer "approve_status"
    t.integer "input_step"
    t.integer "append_file_status"
    t.integer "boss_check_1"
    t.string "boss_check_1_name"
    t.integer "boss_check_2"
    t.string "boss_check_2_name"
    t.integer "boss_check_3"
    t.string "boss_check_3_name"
    t.integer "boss_check_4"
    t.string "boss_check_4_name"
    t.string "type_name"
    t.string "manufacturer_name"
    t.string "supplier_name"
    t.string "quantity"
    t.integer "estimated_cost"
    t.string "location"
    t.string "desired_delivery"
    t.string "category"
    t.string "division"
    t.text "reason"
    t.text "specific_contents"
    t.string "old_asset_no"
    t.integer "old_asset_multi"
    t.string "old_asset_YM"
    t.string "old_asset_handling"
    t.text "wg_comment"
    t.integer "wg_comment_status"
    t.text "wg_reply_comment"
    t.integer "sk_approve_cost"
    t.text "sk_comment"
    t.datetime "apply_update_date"
    t.datetime "tech_update_date"
    t.datetime "boss_update_date"
    t.datetime "approve_update_date"
    t.datetime "wg_comment_update_date"
    t.datetime "wg_reply_comment_update_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attached_files", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "apply_id", null: false
    t.integer "filetype", null: false
    t.string "filename"
    t.string "filepath"
    t.integer "filestatus"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["apply_id"], name: "index_attached_files_on_apply_id"
  end

  create_table "boss1s", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "boss_no"
    t.string "boss_name"
    t.integer "boss_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "boss_email"
    t.string "boss_depart"
    t.integer "apply_id"
  end

  create_table "departments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "year_id", null: false
    t.string "dep_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["year_id"], name: "index_departments_on_year_id"
  end

  create_table "divisions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "new_pur"
    t.integer "replace"
    t.integer "repair"
    t.integer "oh"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tests", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "login", default: "", null: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "login_user"
    t.string "login_department"
    t.integer "login_ref_no"
    t.text "groups"
    t.index ["login"], name: "index_users_on_login", unique: true
  end

  create_table "years", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "target_year"
  end

  add_foreign_key "add_deps", "years"
  add_foreign_key "applies", "add_deps"
  add_foreign_key "applies", "boss1s", on_delete: :nullify
  add_foreign_key "applies", "departments"
  add_foreign_key "applies", "divisions"
  add_foreign_key "attached_files", "applies"
  add_foreign_key "departments", "years"
end
