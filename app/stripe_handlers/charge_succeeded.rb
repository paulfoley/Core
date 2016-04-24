class ChargeSucceeded < ApplicationController

  def self.webhook(event)

    amount_paid = event[:data][:object][:amount] * 0.01
    puts amount_paid

    #stripe_token = "acct_182AhpK49ukgfgoo"
    stripe_token = event[:user_id]
    puts stripe_token

    customer_name = event[:data][:object][:source][:name]
    puts customer_name

    #CloudElements.quickbooks_payment(stripe_token, customer_name, amount_paid)

  end
end