class Org < ActiveRecord::Base
  has_many :users, :dependent => :destroy
  has_many :quickbooks_customers, :dependent => :destroy
  has_many :salesforce_accounts, :dependent => :destroy
  has_many :stripe_customers, :dependent => :destroy
  has_many :salesforce_opportunities, :through => :salesforce_accounts
  has_many :salesforce_contacts, :through => :salesforce_accounts
  has_many :salesforce_leads, :through => :salesforce_accounts
  has_many :quickbooks_payments, :through => :quickbooks_customers
  has_many :quickbooks_payments, :through => :quickbooks_customers
end
