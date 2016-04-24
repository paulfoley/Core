class CreateSalesforceLeads < ActiveRecord::Migration
  def change
    create_table :salesforce_leads do |t|

      t.integer :salesforce_account_id
      t.integer :org_id
      t.integer :NumberOfEmployees
      t.string :lead_id
      t.string :Company
      t.string :Email
      t.string :Description
      t.string :Rating
      t.string :PostalCode
      t.string :Website
      t.string :LastReferencedDate
      t.string :Salutation
      t.string :Name
      t.string :Industry
      t.string :CreatedById
      t.string :OwnerId
      t.string :Phone
      t.string :Street
      t.string :PhotoUrl
      t.string :Status
      t.string :FirstName
      t.string :LastViewedDate
      t.string :Title
      t.string :City
      t.string :SystemModstamp
      t.string :LeadSource
      t.string :State
      t.string :CreatedDate
      t.string :Country
      t.string :LastName
      t.string :LastModifiedById
      t.boolean :IsDeleted
      t.boolean :IsConverted
      t.boolean :IsUnreadByOwner
      t.decimal :AnnualRevenue
      t.timestamps null: false
    end
  end
end
