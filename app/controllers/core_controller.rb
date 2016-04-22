class CoreController < ApplicationController
  before_action :require_login
  #private
  
  def run
    
  end
  
  def add_user
    @org = Org.find_by(:name=>session[:org])
    @email1 = params[:email1]
    InviteMailer.invite_mail(@email)
    flash[:success] = "User Invited!"
    redirect_to :action=>'run'
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
