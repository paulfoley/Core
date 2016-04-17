Rails.configuration.stripe = {
    :publishable_key => ENV['STRIPE_PUBLISHABLE'],
    :secret_key      => ENV['STRIPE_SECRET']
}

puts "In the stripe.rb file"

Stripe.api_key = Rails.configuration.stripe[:secret_key]
STRIPE_PUBLIC_KEY = Rails.configuration.stripe[:publishable_key]

StripeEvent.configure do |events|
  events.subscribe 'charge.succeeded' do |event|
    puts "event for charge.succeedec has been called"
    # Define subscriber behavior based on the event object
    event.class       #=> Stripe::Event
    event.type        #=> "charge.failed"
    event.data.object #=> #<Stripe::Charge:0x3fcb34c115f8>
    #ChargeSucceeded.call(event)
  end
end

=begin
StripeEvent.setup do
    subscribe 'charge.succeeded' do |event|
    end
end
=end

