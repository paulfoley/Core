StripeEvent.configure do |events|
  events.subscribe 'charge.succeeded', ChargeSucceeded.new
end