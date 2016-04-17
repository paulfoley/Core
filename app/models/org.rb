class Org < ActiveRecord::Base
  has_many :users #, dependent: delete_all
  has_many :quickbooks_customers #, dependent: delete_all
  has_many :salesforce_accounts #, dependent: delete_All
  #has_many :quickbooks_opportunities, through :quickbooks_accounts
  #has_many :salesforce_opportunities, through :salesforce_accounts
end
