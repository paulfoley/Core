class CreateQuickbooksCustomers < ActiveRecord::Migration
  def change
    create_table :quickbooks_customers do |t|

      t.timestamps null: false
    end
  end
end
