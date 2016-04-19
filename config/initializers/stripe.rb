Rails.configuration.stripe = {
    :publishable_key => ENV['STRIPE_PUBLISHABLE'],
    :secret_key      => ENV['STRIPE_SECRET']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
STRIPE_PUBLIC_KEY = Rails.configuration.stripe[:publishable_key]

StripeEvent.configure do |events|
  #events.all StripeFixture.new

  # This block disables StripeEvent's retrieval and verification of
  # incoming events. It's a security feature, protecting you from
  # attackers forging events.
  #
  # When sending test events to your webhook from Stripe's dashboard
  # it causes all requests to fail with 401 (unauthorized), so while
  # we're creating our features, we need to turn it off.
  #
  # REMOVE THIS BLOCK AFTER MAKING YOUR FIXTURES!
  events.event_retriever = lambda { |params|
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
  }

end

=begin
  events.subscribe 'charge.succeeded' do |event|
    puts "event for charge.succeedec has been called"
    # Define subscriber behavior based on the event object
    event.class       #=> Stripe::Event
    event.type        #=> "charge.failed"
    event.data.object #=> #<Stripe::Charge:0x3fcb34c115f8>
    #ChargeSucceeded.call(event)
  end
end
=end

=begin
StripeEvent.setup do
    subscribe 'charge.succeeded' do |event|
    end
end
=end

