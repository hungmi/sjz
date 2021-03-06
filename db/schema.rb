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

ActiveRecord::Schema.define(version: 20170801081712) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "departments", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "ordering", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "docs", force: :cascade do |t|
    t.string "name", null: false
    t.string "code"
    t.text "description"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "oss_key"
    t.bigint "folder_id"
    t.bigint "parent_id"
    t.bigint "child_id"
    t.index ["child_id"], name: "index_docs_on_child_id"
    t.index ["code"], name: "index_docs_on_code", unique: true
    t.index ["folder_id"], name: "index_docs_on_folder_id"
    t.index ["oss_key"], name: "index_docs_on_oss_key", unique: true
    t.index ["parent_id"], name: "index_docs_on_parent_id"
  end

  create_table "employees", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "name"
    t.string "mobile_phone"
    t.string "tel"
    t.string "ext"
    t.integer "department_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_employees_on_department_id"
  end

  create_table "folders", force: :cascade do |t|
    t.string "name"
    t.bigint "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_folders_on_name"
  end

  create_table "items", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "spec"
    t.string "quantity"
    t.string "unit"
    t.string "image"
    t.integer "department_id"
    t.integer "employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_items_on_department_id"
    t.index ["employee_id"], name: "index_items_on_employee_id"
  end

  add_foreign_key "docs", "folders"
  add_foreign_key "employees", "departments"
  add_foreign_key "items", "departments"
  add_foreign_key "items", "employees"
end
