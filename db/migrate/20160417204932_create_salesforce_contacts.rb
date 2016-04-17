class CreateSalesforceContacts < ActiveRecord::Migration
  def change
    create_table :salesforce_contacts do |t|

      t.timestamps null: false
    end
  end
end
