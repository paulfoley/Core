class ChargeSucceeded < ApplicationController

  def self.webhook(event)
    #token = Org.where(stripe_token: stripe_token).select(:quickbooks_token).take.quickbooks_token
    # secret key = SELECT access_token FROM database WHERE user_id = stripe_user_id
    stripe_token = event[:user_id]
    puts stripe_token

    customer_name = event[:data][:object][:source][:name]
    puts customer_name

    amount_paid = event[:data][:object][:amount] * 0.01
    puts amount_paid

    CloudElements.quickbooks_payment(stripe_token, customer_name, amount_paid)

  end
end