class ChargeSucceeded
  def call(event)
    Rails.logger.log("Somebody paid us! Woohoo!")

=begin
    charge = event.data.object.id
    balance_transaction = Stripe::BalanceTransaction.retrieve(charge.balance_transaction.to_s)
    @date = Time.at(charge.created)
    @user = User.new
    @user.GENERAL_JOURNAL = @date.strftime("%m/%d/%Y")
    @user.Stripe_Sales = charge.amount * -0.01
    @user.Charge_ID = charge.id
    @user.Description = charge.description
    @user.Email = customer.email
    @user.Stripe_Payment_Processing_Fees = balance_transaction.fee * 0.01
    @user.Fees_for_charge_ID = charge.id
    @user.Stripe_Account = balance_transaction.net * 0.01
    @user.Net_for_charge_ID = charge.id
    @user.save
=end

  end
end