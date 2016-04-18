class CoreController < ApplicationController
  before_action :require_login
  private
  
  def run
    
  end
  
  def require_login
    if !session[:logged_in]
      flash.keep
      flash[:failure] = "You must be logged in to access CORE"
      redirect_to controller:'welcome', action:'index'
    end
  end


end
