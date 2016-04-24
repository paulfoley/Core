Rails.configuration.stripe = {
    :publishable_key => ENV['STRIPE_PUBLISHABLE'],
    :secret_key      => ENV['STRIPE_LIVE_SECRET_KEY']
}

# set Stripe.api_key to unique secret key for each account
# query from database
# secret key = SELECT access_token FROM database WHERE user_id = stripe_user_id
#token = Org.where(stripe_token: stripe_token).select(:quickbooks_token).take.quickbooks_token
Stripe.api_key = Rails.configuration.stripe[:secret_key]
STRIPE_PUBLIC_KEY = Rails.configuration.stripe[:publishable_key]

StripeEvent.event_retriever = Proc.new do |params|
  if params[:type] == "charge.succeeded"
    ChargeSucceeded.webhook(params)
  end
end

=begin
StripeEvent.subscribe 'transfer.paid' do |event|
  puts event
  #key = params[:user_id]
  #puts key
  TransferPaid.webhook(event)
end
=end

=begin
StripeEvent.event_retriever = Proc.new do |params|
  #secret_key = Account.find_by_stripe_user_id(params[:user_id]).secret_key
  secret_key = Account.find_by!(stripe_user_id: params[:user_id]).secret_key
  Stripe::Event.retrieve(params[:id], secret_key)
end
=end
