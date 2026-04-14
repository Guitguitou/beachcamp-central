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

ActiveRecord::Schema[8.1].define(version: 2026_04_14_124148) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "camp_staff_memberships", force: :cascade do |t|
    t.bigint "camp_id", null: false
    t.datetime "created_at", null: false
    t.integer "position", default: 0, null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["camp_id", "user_id"], name: "index_camp_staff_memberships_on_camp_id_and_user_id", unique: true
    t.index ["camp_id"], name: "index_camp_staff_memberships_on_camp_id"
    t.index ["user_id"], name: "index_camp_staff_memberships_on_user_id"
  end

  create_table "camps", force: :cascade do |t|
    t.bigint "coach_id"
    t.string "country", null: false
    t.datetime "created_at", null: false
    t.string "currency", default: "EUR", null: false
    t.text "description"
    t.date "end_date", null: false
    t.boolean "featured", default: false, null: false
    t.integer "level", default: 0, null: false
    t.string "location", null: false
    t.integer "max_participants", default: 16, null: false
    t.integer "min_participants", default: 4, null: false
    t.bigint "organizer_id", null: false
    t.integer "price_cents", default: 0, null: false
    t.date "start_date", null: false
    t.integer "status", default: 0, null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["coach_id"], name: "index_camps_on_coach_id"
    t.index ["organizer_id"], name: "index_camps_on_organizer_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.bigint "camp_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["camp_id"], name: "index_conversations_on_camp_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.bigint "conversation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "registrations", force: :cascade do |t|
    t.bigint "camp_id", null: false
    t.datetime "created_at", null: false
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["camp_id"], name: "index_registrations_on_camp_id"
    t.index ["user_id", "camp_id"], name: "index_registrations_on_user_id_and_camp_id", unique: true
    t.index ["user_id"], name: "index_registrations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.boolean "admin", default: false, null: false
    t.text "bio"
    t.boolean "coach", default: false, null: false
    t.text "coach_bio"
    t.string "coach_headline"
    t.text "coach_track_record"
    t.datetime "created_at", null: false
    t.date "date_of_birth"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.integer "level", default: 0, null: false
    t.boolean "organizer", default: false, null: false
    t.string "phone"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "slug"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "camp_staff_memberships", "camps"
  add_foreign_key "camp_staff_memberships", "users"
  add_foreign_key "camps", "users", column: "coach_id"
  add_foreign_key "camps", "users", column: "organizer_id"
  add_foreign_key "conversations", "camps"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
  add_foreign_key "registrations", "camps"
  add_foreign_key "registrations", "users"
end
