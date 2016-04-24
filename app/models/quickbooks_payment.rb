class QuickbooksPayment < ActiveRecord::Base
  belongs_to :quickbooks_customer
end
