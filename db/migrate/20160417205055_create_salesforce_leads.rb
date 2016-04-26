class CreateSalesforceLeads < ActiveRecord::Migration
  def change
    create_table :salesforce_leads do |t|

      t.string :lead_id
      t.integer :org_id
      t.integer :number_of_employees
      t.string :company
      t.string :email
      t.string :description
      t.string :rating
      t.string :postal_code
      t.string :website
      t.string :last_referenced_date
      t.string :salutation
      t.string :name
      t.string :industry
      t.string :created_by_id
      t.string :owner_id
      t.string :phone
      t.string :street
      t.string :photo_url
      t.string :status
      t.string :first_name
      t.string :last_viewed_date
      t.string :title
      t.string :city
      t.string :lead_source
      t.string :state
      t.string :created_date
      t.string :country
      t.string :last_name
      t.string :last_modified_by_id
      t.boolean :is_deleted
      t.boolean :is_converted
      t.boolean :is_unread_by_owner
      t.decimal :annual_revenue
      t.timestamps null: false
      t.date :date_created
    end
  end
end
