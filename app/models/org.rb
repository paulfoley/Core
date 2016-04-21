class Org < ActiveRecord::Base
  has_many :users, :dependent => :destroy
  has_many :quickbooks_customers, :dependent => :destroy
  has_many :salesforce_accounts, :dependent => :destroy
end
