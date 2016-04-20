class CreateOrgs < ActiveRecord::Migration
  def change

    create_table :orgs do |t|
      t.timestamps null: false
      t.string :name,           null: false, default: ""
      t.string :salesforce_token
      t.string :quickbooks_token
    end
  end
end
