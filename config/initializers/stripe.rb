Rails.configuration.stripe = {
    :publishable_key => ENV['STRIPE_PUBLISHABLE'],
    :secret_key      => ENV['STRIPE_LIVE_SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
STRIPE_PUBLIC_KEY = Rails.configuration.stripe[:publishable_key]

StripeEvent.subscribe 'charge.succeeded' do |event|
  #puts "Called StripeEvent subscribe for charge.succeeded in stripe.rb"
  redirect_to ChargeSucceeded.webhook
end