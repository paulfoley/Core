class QuickbooksCustomer < ActiveRecord::Base
  has_many :quickbooks_invoices
  has_many :quickbooks_payments
  belongs_to :org
end
