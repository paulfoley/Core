class CreateSalesforceAccounts < ActiveRecord::Migration
  def change
    create_table :salesforce_accounts do |t|

      t.timestamps null: false
      t.string :name,           null: false, default: ""

    end
  end
end
