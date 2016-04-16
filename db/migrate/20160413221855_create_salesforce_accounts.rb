class CreateSalesforceAccounts < ActiveRecord::Migration
  def change
    create_table :salesforce_accounts, id: false do |t|

      t.timestamps null: false
      t.string :account_id, primary: true
      t.string :name

    end
  end
end
