class CreateOrgs < ActiveRecord::Migration
  def change

    create_table :orgs do |t|
      t.timestamps null: false
      t.string :name,           null: false, default: ""
      t.string :salesforce_token
      t.string :salesforce_instance_id
      t.string :quickbooks_token
      t.string :quickbooks_instance_id
      t.string :stripe_token
    end

    add_index :orgs, :name,                unique: true

    #Test Org
    Org.create :name => "Acme Inc.", :salesforce_instance_id => "12345", :quickbooks_instance_id => "54321"

  end
end
