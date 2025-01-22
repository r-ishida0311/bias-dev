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

ActiveRecord::Schema[7.1].define(version: 2025_01_22_055344) do
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

  create_table "active_storage_attachments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
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

  create_table "active_storage_variant_records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "emp_no", limit: 4
    t.string "emp_name"
    t.integer "tech_flag"
    t.integer "wg_flag"
    t.integer "sys_flag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "emp_admin_email"
  end

  create_table "applies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "department_id", null: false
    t.string "reference_no"
    t.integer "apply_kind"
    t.string "item_name"
    t.string "apply_emp_no"
    t.string "apply_emp_name"
    t.string "equipment_name"
    t.string "manufacturer_name"
    t.string "supplier_name"
    t.string "quantity"
    t.integer "estimated_cost"
    t.string "location"
    t.date "desired_delivery"
    t.string "category"
    t.string "reason"
    t.string "specific_contents"
    t.string "old_asset_no"
    t.integer "old_asset_multi"
    t.date "old_asset_YM"
    t.string "old_asset_handling"
    t.integer "sk_approve_cost"
    t.integer "old_asset_cost"
    t.integer "year"
    t.string "emp_email"
    t.bigint "role_id"
    t.index ["department_id"], name: "index_applies_on_department_id"
    t.index ["role_id"], name: "index_applies_on_role_id"
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

  create_table "apply_statuses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "apply_status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "apply_id"
    t.index ["apply_id"], name: "index_apply_statuses_on_apply_id"
  end

  create_table "approve_statuses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "approve_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "apply_id"
    t.index ["apply_id"], name: "index_approve_statuses_on_apply_id"
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
    t.string "boss_no", limit: 4
    t.string "boss_name"
    t.integer "boss_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "boss_email"
    t.string "boss_depart"
    t.bigint "apply_id"
    t.index ["apply_id"], name: "index_boss1s_on_apply_id"
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
    t.bigint "apply_id"
    t.index ["apply_id"], name: "index_divisions_on_apply_id"
  end

  create_table "roles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "department_id"
    t.index ["department_id"], name: "index_roles_on_department_id"
  end

  create_table "sk_comments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "sk_user"
    t.string "sk_comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "apply_id"
    t.index ["apply_id"], name: "index_sk_comments_on_apply_id"
  end

  create_table "table_roles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tech_comments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "tech_user"
    t.string "tech_comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "apply_id"
    t.index ["apply_id"], name: "index_tech_comments_on_apply_id"
  end

  create_table "tech_reply_comments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "tech_reply_comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "apply_id"
    t.index ["apply_id"], name: "index_tech_reply_comments_on_apply_id"
  end

  create_table "tech_statuses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "tech_check_name"
    t.integer "tech_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "apply_id"
    t.index ["apply_id"], name: "index_tech_statuses_on_apply_id"
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
    t.string "login_ref_no", limit: 4
    t.text "groups"
    t.string "login_email"
    t.index ["login"], name: "index_users_on_login", unique: true
  end

  create_table "years", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "target_year"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "applies", "departments"
  add_foreign_key "applies", "roles"
  add_foreign_key "apply_statuses", "applies"
  add_foreign_key "approve_statuses", "applies"
  add_foreign_key "attached_files", "applies"
  add_foreign_key "boss1s", "applies"
  add_foreign_key "departments", "years"
  add_foreign_key "divisions", "applies"
  add_foreign_key "roles", "departments"
  add_foreign_key "sk_comments", "applies"
  add_foreign_key "tech_comments", "applies"
  add_foreign_key "tech_reply_comments", "applies"
  add_foreign_key "tech_statuses", "applies"
end
