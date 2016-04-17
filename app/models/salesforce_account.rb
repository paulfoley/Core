class SalesforceAccount < ActiveRecord::Base
  has_many :salesforce_opportunities
  has_many :salesforce_contacts
  has_many :salesforce_leads
  belongs_to :org
end
