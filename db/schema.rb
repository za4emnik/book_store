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

ActiveRecord::Schema.define(version: 20171114151203) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "city"
    t.integer  "zip"
    t.integer  "country_id"
    t.string   "phone"
    t.string   "addressable_type"
    t.integer  "addressable_id"
    t.string   "type"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "use_billing_address", default: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id", using: :btree
    t.index ["country_id"], name: "index_addresses_on_country_id", using: :btree
  end

  create_table "authors", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "authors_books", id: false, force: :cascade do |t|
    t.integer "author_id"
    t.integer "book_id"
  end

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.decimal  "price",       precision: 8, scale: 2
    t.text     "description"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "category_id"
    t.integer  "year"
    t.string   "dimensions"
    t.string   "slug"
    t.index ["slug"], name: "index_books_on_slug", using: :btree
  end

  create_table "books_materials", id: false, force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "material_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "bs_checkout_addresses", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "city"
    t.integer  "zip"
    t.integer  "country_id"
    t.string   "phone"
    t.string   "addressable_type"
    t.integer  "addressable_id"
    t.string   "type"
    t.boolean  "use_billing_address", default: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["addressable_type", "addressable_id"], name: "addressable_type", using: :btree
    t.index ["country_id"], name: "index_bs_checkout_addresses_on_country_id", using: :btree
  end

  create_table "bs_checkout_carts", force: :cascade do |t|
    t.string   "number"
    t.string   "name"
    t.string   "date"
    t.integer  "cvv"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_bs_checkout_carts_on_order_id", using: :btree
  end

  create_table "bs_checkout_countries", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bs_checkout_coupons", force: :cascade do |t|
    t.string   "code"
    t.decimal  "value",      precision: 8, scale: 2
    t.integer  "order_id"
    t.boolean  "active",                             default: true
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.index ["order_id"], name: "index_bs_checkout_coupons_on_order_id", using: :btree
  end

  create_table "bs_checkout_deliveries", force: :cascade do |t|
    t.string   "name"
    t.string   "interval"
    t.decimal  "price",      precision: 5, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "bs_checkout_order_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "quantity",   default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["order_id"], name: "index_bs_checkout_order_items_on_order_id", using: :btree
  end

  create_table "bs_checkout_orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "delivery_id"
    t.decimal  "total",       precision: 8, scale: 2, default: "0.0"
    t.decimal  "subtotal",    precision: 8, scale: 2, default: "0.0"
    t.string   "aasm_state"
    t.string   "number",                              default: "R00000000"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.index ["delivery_id"], name: "index_bs_checkout_orders_on_delivery_id", using: :btree
    t.index ["user_id"], name: "index_bs_checkout_orders_on_user_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
    t.index ["slug"], name: "index_categories_on_slug", using: :btree
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coupons", force: :cascade do |t|
    t.string   "code"
    t.decimal  "value",      precision: 8, scale: 2
    t.integer  "order_id"
    t.boolean  "active",                             default: true
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.index ["order_id"], name: "index_coupons_on_order_id", using: :btree
  end

  create_table "credit_cards", force: :cascade do |t|
    t.string   "number"
    t.string   "name"
    t.string   "date"
    t.integer  "cvv"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_credit_cards_on_order_id", using: :btree
  end

  create_table "deliveries", force: :cascade do |t|
    t.string   "name"
    t.string   "interval"
    t.decimal  "price",      precision: 5, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "materials", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "book_id"
    t.integer  "quantity",   default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["book_id"], name: "index_order_items_on_book_id", using: :btree
    t.index ["order_id"], name: "index_order_items_on_order_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "delivery_id"
    t.decimal  "total",       precision: 8, scale: 2, default: "0.0"
    t.decimal  "subtotal",    precision: 8, scale: 2, default: "0.0"
    t.string   "aasm_state"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "number",                              default: "R00000000"
    t.index ["delivery_id"], name: "index_orders_on_delivery_id", using: :btree
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "pictures", force: :cascade do |t|
    t.string   "image"
    t.integer  "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_pictures_on_book_id", using: :btree
  end

  create_table "reviews", force: :cascade do |t|
    t.string   "title"
    t.string   "score"
    t.text     "message"
    t.integer  "book_id"
    t.integer  "user_id"
    t.string   "aasm_state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_reviews_on_book_id", using: :btree
    t.index ["user_id"], name: "index_reviews_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "is_admin",               default: false
    t.string   "provider"
    t.string   "uid"
    t.string   "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
