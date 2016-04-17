class CreateSalesforceAccounts < ActiveRecord::Migration
  def change
    create_table :salesforce_accounts do |t|

      t.timestamps null: false
      t.string :account_id#, primary_key: true
      t.string :name
      t.integer :org_id
      t.string :description
      t.string :website
      t.integer :number_of_employees
      t.integer :annual_revenue
      t.string :industry
      t.string :type
      t.string :phone
      t.string :fax
      t.string :billing_country
      t.string :billing_state
      t.string :billing_city
      t.string :billing_postal_code
      t.string :billing_street
      t.string :shipping_country
      t.string :shipping_state
      t.string :shipping_city
      t.string :shipping_postal_code
      t.string :shipping_street


    end
  end
end
