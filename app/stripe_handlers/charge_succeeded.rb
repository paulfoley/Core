class ChargeSucceeded < ApplicationController

  def self.webhook(event)
    # stripe handler for charge.succeeded event
    stripe_token = event[:user_id]
    puts stripe_token

=begin
    customer_id = event[:data][:object][:customer]
    customer = Stripe::Customer.retrieve(customer_id.to_s)
    #puts customer
    card_id = event[:data][:object][:source][:id]
    card = customer.sources.retrieve(card_id.to_s)
    #puts card
    customer_name = card.name
    puts customer_name
=end

    # pull customer from database
    # use email to match with the customer generated when sale made in SF -> invoice in QB
    customer_id = event[:data][:object][:customer]
    customer = Stripe::Customer.retrieve(customer_id.to_s)
    #puts customer
    stripe_email = customer.email
    #puts stripe_email
    customer_name = SalesforceContact.where(email: stripe_email).select(:name).take.name
    puts customer_name

    amount_paid = event[:data][:object][:amount] * 0.01
    puts amount_paid

    # call quickbooks_payment to automate data transfer of payment from Stripe to QB
    CloudElements.quickbooks_payment(stripe_token, customer_name, amount_paid)

  end
end