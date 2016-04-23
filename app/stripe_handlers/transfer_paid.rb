class TransferPaid < ApplicationController

  def self.webhook(event)
    #puts "Somebody paid us!!"
    #puts event
    balance_id = event[:data][:object][:balance_transaction].to_s
    puts balance_id
    amount = event[:data][:object][:amount] * 0.01
    puts amount
    customer_name = 'Company Jon'
    balance_transaction = Stripe::BalanceTransaction.retrieve(balance_id)
    puts balance_transaction

    # key to validate user
    # Any way to get the secret key???
    key = event[:user_id]
    puts key

    # use key to retrieve the customer name from the database?


    #CloudElements.quickbooks_payment(customer_name, amount.to_s)


    #charge = Stripe::Charge.retrieve(params[:data][:object][:id].to_s)
    #balance_transaction = Stripe::BalanceTransaction.retrieve(charge.balance_transaction.to_s)
    #customer = Stripe::Customer.retrieve(charge.customer.to_s)

=begin
    @date = Time.at(charge.created)
    @stripe_customer = StripeCustomer.new
    @stripe_customer.GENERAL_JOURNAL = @date.strftime("%m/%d/%Y")
    @stripe_customer.Stripe_Sales = charge.amount * -0.01
    @stripe_customer.Charge_ID = charge.id
    @stripe_customer.Description = charge.description
    @stripe_customer.Email = params[:data][:object][:receipt_email]
    @stripe_customer.Stripe_Payment_Processing_Fees = balance_transaction.fee * 0.01
    @stripe_customer.Fees_for_charge_ID = charge.id
    @stripe_customer.Stripe_Account = balance_transaction.net * 0.01
    @stripe_customer.Net_for_charge_ID = charge.id
    @stripe_customer.save
=end

  end
end