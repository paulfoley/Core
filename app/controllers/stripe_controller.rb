require 'json'
class StripeController < ApplicationController
  skip_before_action :verify_authenticity_token
  #protect_from_forgery :except => :webhook

  def webhook
    #data_json = JSON.parse(request.body.read)
    #event = Stripe::Event.retrieve(data_json['id'])

    #Rails.logger.log("Webhook function called")
    puts "Webhook function called"

    #event = Stripe::Event.retrieve(params[:id])
    event = Stripe::Event.retrieve({id: params[:id]}, ENV['SECRET_KEY'])
    if event.type = "charge.succeeded"
      charge = Stripe::Charge.retrieve(event.data.object.id.to_s)
      balance_transaction = Stripe::BalanceTransaction.retrieve(charge.balance_transaction.to_s)
      @date = Time.at(charge.created)
      @stripe_customer = stripe_customer.new
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
    else
      Rails.logger.log("Webhook received params.inspect. Did not handle this event.")
    end

  end
end