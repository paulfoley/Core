class ChargeSucceeded
  def call(event)
    #Rails.logger.log("Somebody paid us! Woohoo!")
    puts "Now in the charge succeeded class"

    event = Stripe::Event.construct_from(params.deep_symbolize_keys)
    charge = Stripe::Charge.retrieve(event.data.object.id.to_s)
    customer = Stripe::Customer.retrieve(charge.customer)
    balance_transaction = Stripe::BalanceTransaction.retrieve(charge.balance_transaction.to_s)
    @date = Time.at(charge.created)
    @stripe_customer = StripeCustomer.new
    @stripe_customer.GENERAL_JOURNAL = @date.strftime("%m/%d/%Y")
    @stripe_customer.Stripe_Sales = charge.amount * -0.01
    @stripe_customer.Charge_ID = charge.id
    @stripe_customer.Description = charge.description
    @stripe_customer.Email = customer.email
    @stripe_customer.Stripe_Payment_Processing_Fees = balance_transaction.fee * 0.01
    @stripe_customer.Fees_for_charge_ID = charge.id
    @stripe_customer.Stripe_Account = balance_transaction.net * 0.01
    @stripe_customer.Net_for_charge_ID = charge.id
    @stripe_customer.save

  end
end