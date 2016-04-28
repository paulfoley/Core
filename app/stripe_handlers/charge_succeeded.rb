class ChargeSucceeded < ApplicationController

  def self.webhook(event)
    # stripe handler for charge.succeeded event
    stripe_token = event[:user_id]
    puts stripe_token

    customer_id = event[:data][:object][:customer]
    customer = Stripe::Customer.retrieve(customer_id.to_s)
    #puts customer
    card_id = event[:data][:object][:source][:id]
    card = customer.sources.retrieve(card_id.to_s)
    #puts card
    customer_name = card.name
    puts customer_name

    #customer_name = Org.where(stripe_token: stripe_token).select(:name).take.name
    #puts customer_name

    amount_paid = event[:data][:object][:amount] * 0.01
    puts amount_paid

    # call quickbooks_payment to automate data transfer of payment from Stripe to QB
    CloudElements.quickbooks_payment(stripe_token, customer_name, amount_paid)

  end
end