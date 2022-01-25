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

ActiveRecord::Schema.define(version: 2022_01_19_010903) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
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
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "archives", force: :cascade do |t|
    t.string "caption"
    t.string "fname"
    t.string "path"
    t.string "pdate"
    t.string "pyear"
    t.string "county"
    t.string "county1"
    t.string "county2"
    t.string "county3"
    t.string "county4"
    t.string "county5"
    t.string "county6"
    t.string "county7"
    t.string "county8"
    t.string "county9"
    t.string "county10"
    t.string "city"
    t.string "city1"
    t.string "city2"
    t.string "city3"
    t.string "city4"
    t.string "city5"
    t.string "city6"
    t.string "city7"
    t.string "city8"
    t.string "city9"
    t.string "city10"
    t.string "city11"
    t.string "category"
    t.string "category1"
    t.string "category2"
    t.string "category3"
    t.string "category4"
    t.string "category5"
    t.string "category6"
    t.string "category7"
    t.string "category8"
    t.string "category9"
    t.string "category10"
    t.string "category11"
    t.string "category12"
    t.string "category13"
    t.string "category14"
    t.string "category15"
    t.string "category16"
    t.string "category17"
    t.string "category18"
    t.string "category19"
    t.string "category20"
    t.string "state"
    t.string "state1"
    t.string "state2"
    t.string "state3"
    t.string "state4"
    t.string "state5"
    t.string "state6"
    t.string "options"
    t.string "options1"
    t.string "options2"
    t.float "cost"
    t.float "price"
    t.float "picval"
    t.boolean "cover_page"
    t.boolean "pic_status"
    t.integer "ptype"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "bookmarks", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "user_type"
    t.string "document_id"
    t.string "document_type"
    t.binary "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_bookmarks_on_document_id"
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "searches", force: :cascade do |t|
    t.binary "query_params"
    t.integer "user_id"
    t.string "user_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_searches_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "guest", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
