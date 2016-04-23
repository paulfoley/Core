class CoreController < ApplicationController
  before_action :require_login
  #private
  
  def run
    @connected_to_salesforce = !!Org.where(name: session[:org]).select(:salesforce_token).take.salesforce_token
    @connected_to_quickbooks = !!Org.where(name: session[:org]).select(:quickbooks_token).take.quickbooks_token
    @connected_to_stripe = !!Org.where(name: session[:org]).select(:stripe_token).take.stripe_token
    #variables available in main view
    @user = User.find_by(name: session[:name])
    @org = Org.find_by(name: session[:org])
  end
  
  def invite_user
    @org = Org.find_by(:name=>session[:org])
    @org_name = @org.name
    @email = params[:email]
    InviteMailer.invite_mail(@email,@org_name).deliver_now
    flash[:success] = "User Invited!"
    redirect_to controller:'core', action:'run'
  end
  
  def logout
    session[:logged_in] = false
    flash[:failure] = "Logged Out"
    redirect_to controller:'welcome', action:'index'
  end
  
  def require_login
    if !session[:logged_in]
      flash[:failure] = "You must be logged in to access CORE"
      redirect_to controller:'welcome', action:'index'
    end
  end


end
