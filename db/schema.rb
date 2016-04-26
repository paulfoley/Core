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

ActiveRecord::Schema.define(version: 20160426013137) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "databases", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orgs", force: :cascade do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name",                   default: "", null: false
    t.string   "salesforce_token"
    t.string   "salesforce_instance_id"
    t.string   "quickbooks_token"
    t.string   "quickbooks_instance_id"
    t.string   "stripe_token"
  end

  add_index "orgs", ["name"], name: "index_orgs_on_name", unique: true, using: :btree

  create_table "quickbooks_customers", force: :cascade do |t|
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "customer_id"
    t.string   "name"
    t.string   "org_id"
    t.string   "display_name"
    t.string   "company_name"
    t.string   "fully_qualified_name"
    t.string   "print_on_check_name"
    t.string   "domain"
    t.boolean  "taxable"
    t.boolean  "active"
    t.decimal  "balance"
    t.decimal  "balance_with_jobs"
    t.date     "date_created"
  end

  create_table "quickbooks_invoices", force: :cascade do |t|
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "org_id"
    t.integer  "quickbooks_customer_id"
    t.string   "sync_token"
    t.string   "doc_number"
    t.string   "due_date"
    t.string   "invoice_id"
    t.string   "print_status"
    t.string   "email_status"
    t.string   "domain"
    t.string   "txn_date"
    t.decimal  "balance"
    t.decimal  "total_amt"
    t.boolean  "allow_online_ach_payment"
    t.boolean  "allow_online_payment"
    t.boolean  "allow_ipn_payment"
    t.boolean  "apply_tax_after_discount"
    t.boolean  "allow_online_credit_card_payment"
    t.boolean  "sparse"
    t.date     "date_created"
  end

  create_table "quickbooks_payments", force: :cascade do |t|
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "org_id"
    t.integer  "quickbooks_customer_id"
    t.string   "payment_id"
    t.string   "sync_token"
    t.string   "domain"
    t.string   "payment_ref_num"
    t.string   "txn_date"
    t.boolean  "process_payments"
    t.boolean  "sparse"
    t.decimal  "unapplied_amt"
    t.decimal  "total_amt"
    t.date     "date_created"
  end

  create_table "quickbooks_reports", force: :cascade do |t|
    t.string   "report_id"
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
    t.string   "account_type"
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
    t.date     "date_created"
  end

  create_table "salesforce_contacts", force: :cascade do |t|
    t.integer  "org_id"
    t.integer  "salesforce_account_id"
    t.string   "contact_id"
    t.string   "assistant_phone"
    t.string   "other_phone"
    t.string   "account_id"
    t.string   "email"
    t.string   "description"
    t.string   "assistant_name"
    t.string   "last_referenced_date"
    t.string   "salutation"
    t.string   "other_state"
    t.string   "mobile_phone"
    t.string   "name"
    t.string   "department"
    t.string   "created_by_id"
    t.string   "owner_id"
    t.string   "other_city"
    t.string   "phone"
    t.string   "other_country"
    t.string   "photo_url"
    t.string   "first_name"
    t.string   "other_postal_code"
    t.string   "last_viewed_date"
    t.string   "title"
    t.string   "birthdate"
    t.string   "other_street"
    t.string   "lead_source"
    t.string   "home_phone"
    t.string   "reports_to_id"
    t.string   "created_date"
    t.string   "last_name"
    t.string   "fax"
    t.boolean  "is_deleted"
    t.boolean  "is_email_bounced"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.date     "date_created"
  end

  create_table "salesforce_leads", force: :cascade do |t|
    t.string   "lead_id"
    t.integer  "org_id"
    t.integer  "number_of_employees"
    t.string   "company"
    t.string   "email"
    t.string   "description"
    t.string   "rating"
    t.string   "postal_code"
    t.string   "website"
    t.string   "last_referenced_date"
    t.string   "salutation"
    t.string   "name"
    t.string   "industry"
    t.string   "created_by_id"
    t.string   "owner_id"
    t.string   "phone"
    t.string   "street"
    t.string   "photo_url"
    t.string   "status"
    t.string   "first_name"
    t.string   "last_viewed_date"
    t.string   "title"
    t.string   "city"
    t.string   "lead_source"
    t.string   "state"
    t.string   "created_date"
    t.string   "country"
    t.string   "last_name"
    t.string   "last_modified_by_id"
    t.boolean  "is_deleted"
    t.boolean  "is_converted"
    t.boolean  "is_unread_by_owner"
    t.decimal  "annual_revenue"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.date     "date_created"
  end

  create_table "salesforce_opportunities", force: :cascade do |t|
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "org_id"
    t.integer  "salesforce_account_id"
    t.string   "account_id"
    t.string   "opportunity_id"
    t.string   "description"
    t.string   "forecast_category"
    t.string   "last_referenced_date"
    t.string   "close_date"
    t.string   "name"
    t.string   "stage_name"
    t.string   "last_viewed_date"
    t.string   "fiscal"
    t.string   "opportunity_type"
    t.string   "lead_source"
    t.string   "forecast_category_name"
    t.string   "last_modified_by_id"
    t.string   "next_step"
    t.integer  "probability"
    t.integer  "fiscal_quarter"
    t.integer  "fiscal_year"
    t.decimal  "amount"
    t.boolean  "is_won"
    t.boolean  "is_deleted"
    t.boolean  "has_opportunity_line_item"
    t.boolean  "is_closed"
    t.date     "date_created"
  end

  create_table "salesforce_reports", force: :cascade do |t|
    t.integer  "org_id"
    t.string   "name"
    t.string   "report_id"
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
    t.json     "settings"
    t.string   "position"
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
