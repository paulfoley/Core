class ChargesController < ApplicationController

  def new
  end

  def create
    # Amount in cents
    @amount = 500

    customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        # stripeToken represents provided payment method
        :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount,
        :description => 'Rails Stripe customer',
        :currency    => 'usd'
    )

    balance_transaction = Stripe::BalanceTransaction.retrieve(charge.balance_transaction.to_s)

    @date = Time.at(charge.created)

    @user = User.new
    @user.GENERAL_JOURNAL = @date.strftime("%m/%d/%Y")
    @user.Stripe_Sales = charge.amount * -0.01
    @user.Charge_ID = charge.id
    @user.Description = charge.description
    @user.Email = customer.email
    @user.Stripe_Payment_Processing_Fees = balance_transaction.fee * 0.01
    @user.Fees_for_charge_ID = charge.id
    @user.Stripe_Account = balance_transaction.net * 0.01
    @user.Net_for_charge_ID = charge.id
    @user.save

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

end
