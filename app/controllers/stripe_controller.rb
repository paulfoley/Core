class StripeController < ApplicationController
  #skip_before_filter  :verify_authenticity_token
  #skip_before_action :verify_authenticity_token
  protect_from_forgery :except => :webhook
  respond_to :json
  require 'json'

  def webhook
    render json:{}
    balance_id = params[:data][:object][:balance_transaction].to_s
    puts balance_id
    #puts params[:data][:object][:amount] * 0.01
    amount = params[:data][:object][:amount] * 0.01
    puts amount
    customer_name = 'Company Jon'
    #puts profit
    #balance_transaction = Stripe::BalanceTransaction.retrieve(balance_id)
    #puts balance_transaction
    key = event[:user_id].to_s
    puts key

    CloudElements.quickbooks_payment(key, customer_name, amount.to_s)


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

    #puts params[:data][:object][:source][:name]
    #puts params[:data][:object][:amount]

=begin
    customer_name = params[:data][:object][:source][:name].to_s
    amount = params[:data][:object][:amount].to_s
    CloudElements.quickbooks_payments(user_id, customer_name, amount)
=end

  end
end