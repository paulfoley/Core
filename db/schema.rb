# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160417212211) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "databases", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orgs", force: :cascade do |t|
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "name",             default: "", null: false
    t.string   "salesforce_token"
    t.string   "quickbooks_token"
  end

  create_table "quickbooks_customers", force: :cascade do |t|
    t.string   "account_id"
    t.string   "name"
    t.string   "org_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "salesforce_accounts", force: :cascade do |t|
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "account_id"
    t.string   "name"
    t.integer  "org_id"
    t.string   "description"
    t.string   "website"
    t.integer  "number_of_employees"
    t.integer  "annual_revenue"
    t.string   "industry"
    t.string   "type"
    t.string   "phone"
    t.string   "fax"
    t.string   "billing_country"
    t.string   "billing_state"
    t.string   "billing_city"
    t.string   "billing_postal_code"
    t.string   "billing_street"
    t.string   "shipping_country"
    t.string   "shipping_state"
    t.string   "shipping_city"
    t.string   "shipping_postal_code"
    t.string   "shipping_street"
  end

  create_table "salesforce_contacts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "salesforce_leads", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "salesforce_opportunities", force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "opportunity_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id"
    t.string   "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stripe_customers", force: :cascade do |t|
    t.string   "account_id"
    t.datetime "created_at",                                                            null: false
    t.datetime "updated_at",                                                            null: false
    t.string   "GENERAL_JOURNAL",                                         default: "",  null: false
    t.string   "Description",                                                           null: false
    t.string   "Email",                                                                 null: false
    t.decimal  "Stripe_Sales",                   precision: 15, scale: 2, default: 0.0, null: false
    t.string   "Charge_ID",                                               default: "",  null: false
    t.string   "Rails_Stripe_customer",                                   default: "",  null: false
    t.decimal  "Stripe_Payment_Processing_Fees", precision: 15, scale: 2, default: 0.0, null: false
    t.string   "Fees_for_charge_ID",                                      default: "",  null: false
    t.decimal  "Stripe_Account",                 precision: 15, scale: 2, default: 0.0, null: false
    t.string   "Net_for_charge_ID",                                       default: "",  null: false
    t.integer  "org_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer  "org_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "name",                   default: "",    null: false
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
    t.boolean  "is_admin",               default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
