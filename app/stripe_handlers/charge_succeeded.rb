class ChargeSucceeded < ApplicationController

  def self.webhook(event)
    stripe_token = event[:user_id]
    puts stripe_token

    #customer_name = event[:data][:object][:source][:name]
    #puts customer_name

    #customer_id = event[:data][:object][:customer]
    #puts customer_id
    #customer = Stripe::Customer.retrieve(customer_id.to_s)
    #puts customer

    #puts event[:data][:object][:source][:id]
    #card_id = event[:data][:object][:source][:id]
    #card = customer.sources.retrieve(card_id.to_s)
    #puts card

    customer_name = Org.where(stripe_token: stripe_token).select(:name).take.name
    #customer_name = Org.where(salesforce_instance_id: 12345).select(:name).take.name
    puts customer_name
    #customer_name = card.name
    #puts customer_name
    #puts customer.sources.data.id
    #card_id = customer.sources.data.id.to_s
    #card = customer.sources.retrieve()

    amount_paid = event[:data][:object][:amount] * 0.01
    puts amount_paid

    CloudElements.quickbooks_payment(stripe_token, customer_name, amount_paid)

  end
end