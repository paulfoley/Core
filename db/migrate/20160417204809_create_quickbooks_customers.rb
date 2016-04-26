class CreateQuickbooksCustomers < ActiveRecord::Migration
  def change
    create_table :quickbooks_customers do |t|

      t.timestamps null: false
      t.string :customer_id
      t.string :name
      t.string :org_id
      t.string :display_name
      t.string :company_name
      t.string :fully_qualified_name
      t.string :print_on_check_name
      t.string :domain
      t.boolean :taxable
      t.boolean :active
      t.decimal :balance
      t.decimal :balance_with_jobs
      t.date :date_created

    end
  end
end
