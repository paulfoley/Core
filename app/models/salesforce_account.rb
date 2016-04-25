class SalesforceAccount < ActiveRecord::Base
  has_many :salesforce_opportunities
  has_many :salesforce_contacts
  belongs_to :org
end
