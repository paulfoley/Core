Rails.configuration.stripe = {
    :publishable_key => ENV['STRIPE_PUBLISHABLE'],
    :secret_key      => ENV['STRIPE_LIVE_SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
STRIPE_PUBLIC_KEY = Rails.configuration.stripe[:publishable_key]

StripeEvent.subscribe 'transfer.paid' do |event|
  TransferPaid.webhook(event)
end

=begin
StripeEvent.event_retriever = Proc.new do |params|
  #secret_key = Account.find_by_stripe_user_id(params[:user_id]).secret_key
  secret_key = Account.find_by!(stripe_user_id: params[:user_id]).secret_key
  Stripe::Event.retrieve(params[:id], secret_key)
end
=end
