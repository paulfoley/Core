Rails.configuration.stripe = {
    :publishable_key => ENV['STRIPE_PUBLISHABLE'],
    :secret_key      => ENV['STRIPE_SECRET']
}

#puts "In the stripe.rb file"

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
    Stripe::Event.construct_from(params.deep_symbolize_keys)
    puts "within the stripe event retriever in the stripe.rb file"
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

