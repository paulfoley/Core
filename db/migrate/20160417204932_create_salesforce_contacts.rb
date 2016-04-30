class CreateSalesforceContacts < ActiveRecord::Migration
  def change
    create_table :salesforce_contacts do |t|
      t.integer :org_id
      t.integer :salesforce_account_id
      t.string :contact_id
      t.string :assistant_phone
      t.string :other_phone
      t.string :account_id
      t.string :email
      t.string :description
      t.string :assistant_name
      t.string :last_referenced_date
      t.string :salutation
      t.string :other_state
      t.string :mobile_phone
      t.string :name
      t.string :department
      t.string :created_by_id
      t.string :owner_id
      t.string :other_city
      t.string :phone
      t.string :other_country
      t.string :photo_url
      t.string :first_name
      t.string :other_postal_code
      t.string :last_viewed_date
      t.string :title
      t.string :birthdate
      t.string :other_street
      t.string :lead_source
      t.string :home_phone
      t.string :reports_to_id
      t.string :created_date
      t.string :last_name
      t.string :fax
      t.boolean :is_deleted
      t.boolean :is_email_bounced
      t.timestamps null: false
      t.date :date_created
    end
  end
end
