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

ActiveRecord::Schema.define(version: 2021_01_27_190751) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "academic_works", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.string "summary"
    t.string "course"
    t.date "defense_date"
    t.string "document_link"
    t.string "work_type"
    t.string "keyword"
    t.string "how_to_quote"
    t.string "appraisers"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "institution"
    t.bigint "course_id", null: false
    t.bigint "teacher_id", null: false
    t.index ["course_id"], name: "index_academic_works_on_course_id"
    t.index ["teacher_id"], name: "index_academic_works_on_teacher_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "collaborations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "idea_id", null: false
    t.boolean "quit"
    t.datetime "collaboration_date"
    t.datetime "withdrawal_date"
    t.string "reason"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "type_collaboration"
    t.index ["idea_id"], name: "index_collaborations_on_idea_id"
    t.index ["user_id"], name: "index_collaborations_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "academic_works_count", default: 0
  end

  create_table "idea_categories", force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "img_link"
    t.string "img"
    t.string "link_or_image"
  end

  create_table "idea_category_ideas", force: :cascade do |t|
    t.bigint "idea_id", null: false
    t.bigint "idea_category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["idea_category_id"], name: "index_idea_category_ideas_on_idea_category_id"
    t.index ["idea_id"], name: "index_idea_category_ideas_on_idea_id"
  end

  create_table "ideas", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "status"
    t.boolean "possibility_reward"
    t.boolean "possibility_business"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "ideializer_id", null: false
    t.string "problem_to_solve"
    t.string "suffering_people"
    t.string "proposed_solution"
    t.string "differential"
    t.bigint "idea_category_id", null: false
    t.string "locality"
    t.index ["idea_category_id"], name: "index_ideas_on_idea_category_id"
    t.index ["ideializer_id"], name: "index_ideas_on_ideializer_id"
  end

  create_table "menus", force: :cascade do |t|
    t.boolean "active"
    t.string "icon"
    t.string "name"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "ancestry"
    t.index ["ancestry"], name: "index_menus_on_ancestry"
  end

  create_table "profile_menus", force: :cascade do |t|
    t.bigint "menu_id", null: false
    t.bigint "profile_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["menu_id"], name: "index_profile_menus_on_menu_id"
    t.index ["profile_id"], name: "index_profile_menus_on_profile_id"
  end

  create_table "profile_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "profile_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["profile_id"], name: "index_profile_users_on_profile_id"
    t.index ["user_id"], name: "index_profile_users_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.boolean "active"
    t.json "permissions"
    t.string "namespace"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
    t.integer "academic_works_count", default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "telephone"
    t.string "biography"
    t.string "type_collaborator"
    t.bigint "registered_by_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["registered_by_id"], name: "index_users_on_registered_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "academic_works", "courses"
  add_foreign_key "academic_works", "teachers"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "collaborations", "ideas"
  add_foreign_key "collaborations", "users"
  add_foreign_key "idea_category_ideas", "idea_categories"
  add_foreign_key "idea_category_ideas", "ideas"
  add_foreign_key "ideas", "idea_categories"
  add_foreign_key "ideas", "users", column: "ideializer_id"
  add_foreign_key "profile_menus", "menus"
  add_foreign_key "profile_menus", "profiles"
  add_foreign_key "profile_users", "profiles"
  add_foreign_key "profile_users", "users"
  add_foreign_key "users", "users", column: "registered_by_id"
end
