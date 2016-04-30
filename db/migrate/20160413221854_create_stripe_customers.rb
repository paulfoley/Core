class CreateStripeCustomers < ActiveRecord::Migration
  def change
    create_table :stripe_customers do |t|
      t.string :account_id, primary: true
      t.datetime "created_at",                                                              null: false
      t.datetime "updated_at",                                                              null: false
      t.string   "access_token",                    default: "", null: false
      t.string   "stripe_live_secret_key",                        default: "", null: false
      t.string   "stripe_test_secret_key",                   default: "", null: false
      t.string   "stripe_live_publishable_key",                      default: "", null: false
      t.string   "stripe_test_publishable_key",          default: "", null: false
      t.string   "stripe_user_id",                  default: "", null: false
      t.string   "scope",                           default: "", null: false

      t.integer :org_id
    end
  end
end
