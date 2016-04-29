class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def stripe_connect

    #Stripe.api_key = request.env["omniauth.auth"].credentials.token
    #STRIPE_PUBLIC_KEY = request.env["omniauth.auth"].info.stripe_publishable_key
    auth = request.env["omniauth.auth"]
    puts auth


=begin
    @stripe_customer = current_user
    if @stripe_customer.update_attributes({
                                   provider: request.env["omniauth.auth"].provider,
                                   uid: request.env["omniauth.auth"].uid,
                                   access_code: request.env["omniauth.auth"].credentials.token,
                                   publishable_key: request.env["omniauth.auth"].info.stripe_publishable_key
                               })
      # anything else you need to do in response..
      sign_in_and_redirect @stripe_customer, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Stripe") if is_navigational_format?
    else
      session["devise.stripe_connect_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
=end


  end
end