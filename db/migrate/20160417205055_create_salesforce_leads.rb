class CreateSalesforceLeads < ActiveRecord::Migration
  def change
    create_table :salesforce_leads do |t|

      t.timestamps null: false
    end
  end
end
