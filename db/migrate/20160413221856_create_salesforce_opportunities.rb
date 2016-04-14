class CreateSalesforceOpportunities < ActiveRecord::Migration
  def change
    create_table :salesforce_opportunities do |t|

      t.timestamps null: false
      t.string :opportunity_id
    end
  end
end
