class WelcomeController < ApplicationController

  def index

  end
  
  def check_user
    @email = params[:email]
  end
  helper_method :check_user

end