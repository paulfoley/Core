class CreateQuickbooksCustomers < ActiveRecord::Migration
  def change
    create_table :quickbooks_customers do |t|
      t.timestamps null: false
      t.string :name,               null: false, default: ""
      t.string :email,              null: false, default: ""
      t.string :company,            null: false, default: ""
      t.integer :org_id
    end
  end
end
