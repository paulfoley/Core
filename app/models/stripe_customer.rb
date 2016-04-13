class StripeCustomer < ActiveRecord::Base

  belongs_to :org

  def new
  end

end
