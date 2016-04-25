class QuickbooksPayment < ActiveRecord::Base
  belongs_to :quickbooks_customer
  belongs_to :org
end
