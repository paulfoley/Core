class TransferPaid < ApplicationController

  def self.webhook(event)
    #puts "Somebody paid us!!"
    puts event
    balance_id = event[:data][:object][:balance_transaction]
    puts balance_id
    amount_paid = event[:data][:object][:amount] * 0.01
    puts amount_paid
    balance_transaction = Stripe::BalanceTransaction.retrieve(balance_id)
    puts balance_transaction

    #transfer = event[:data][:object][:id]
    #transfer = Stripe::Transfer.retrieve("tr_181tgBFjVatL4SEryMOdq0dc")
    #puts transfer

    #stripe_token = "acct_182AhpK49ukgfgoo"
    stripe_token = event[:user_id]
    puts stripe_token

    #customer_name = event[:data][:object][:bank_account][:account_holder_name]
    #puts customer_name
    customer_name = event[:data][:source][:name]
    puts customer_name

    # use key to retrieve the customer name from the database?

=begin
      charge = Stripe::Charge.retrieve(params[:data][:object][:id].to_s)
      balance_transaction = Stripe::BalanceTransaction.retrieve(charge.balance_transaction.to_s)
      #customer = Stripe::Customer.retrieve(charge.customer.to_s)
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

    CloudElements.quickbooks_payment(stripe_token, customer_name, amount_paid)

  end
end