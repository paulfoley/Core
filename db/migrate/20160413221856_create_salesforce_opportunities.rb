class CreateSalesforceOpportunities < ActiveRecord::Migration
  def change
    create_table :salesforce_opportunities do |t|

      t.timestamps null: false
      t.integer :salesforce_account_id
      
    end
  end
end
