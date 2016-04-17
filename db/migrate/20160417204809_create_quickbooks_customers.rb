class CreateQuickbooksCustomers < ActiveRecord::Migration
  def change
    create_table :quickbooks_customers do |t|
      t.string :account_id
      t.string :name
      t.string :org_id

      t.timestamps null: false
    end
  end
end
