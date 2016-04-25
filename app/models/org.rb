class Org < ActiveRecord::Base
  has_many :users, :dependent => :destroy
  has_many :quickbooks_customers, :dependent => :destroy
  has_many :salesforce_accounts, :dependent => :destroy
  has_many :stripe_customers, :dependent => :destroy
  has_many :salesforce_opportunities, :dependent => :destroy
  has_many :salesforce_contacts, :dependent => :destroy
  has_many :salesforce_leads, :dependent => :destroy
  has_many :quickbooks_payments, :dependent => :destroy
  has_many :quickbooks_invoices, :dependent => :destroy
end
