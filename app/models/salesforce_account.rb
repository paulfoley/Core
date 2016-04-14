class SalesforceAccount < ActiveRecord::Base
  has_many :salesforce_opportunities
  belongs_to :org
end
