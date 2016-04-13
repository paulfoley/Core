class CreateStripeCustomers < ActiveRecord::Migration
  def change
    create_table :stripe_customers do |t|
      t.datetime "created_at",                                                              null: false
      t.datetime "updated_at",                                                              null: false
      t.string   "GENERAL_JOURNAL",                 default: "", null: false
      t.string   "Description",                                                             null: false
      t.string   "Email",                                                                   null: false
      t.decimal  "Stripe_Sales",                    precision: 15, scale: 2, default: 0.00,  null: false
      t.string   "Charge_ID",                       default: "", null: false
      t.string   "Rails_Stripe_customer",           default: "", null: false
      t.decimal  "Stripe_Payment_Processing_Fees",  precision: 15, scale: 2, default: 0.00,  null: false
      t.string   "Fees_for_charge_ID",              default: "", null: false
      t.decimal  "Stripe_Account",                  precision: 15, scale: 2, default: 0.00,  null: false
      t.string   "Net_for_charge_ID",               default: "", null: false

    end
  end
end
