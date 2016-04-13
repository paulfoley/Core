class WelcomeController < ApplicationController

  def index

  end
  
  def check_user
    
    @email = params[:email]
    @password = params[:password]
    
    if User.exists?(email: @email)
      @user = User.find_by_email(@email)
      
      if @user.valid_password?(@password)
        redirect_to controller:'core', action:'run'
      else 
        flash.notice = "Incorrect Password"
        redirect_to action:'index'
      end
    else
      flash.notice = "Username not found"
      redirect_to action:'index'
    end
  end
  helper_method :check_user
  
  def signup
    @email = params[:email]
    #if params[:password1] != params[:password2]
      #flash[:notice] = "Mismatched Passwords"
    #else
      @new_user = User.create(:name=>params[:username], :email=>params[:email], :password=>params[:password1])
      flash.notice = "User created!"
      redirect_to action:'index'
    #end
  end
  
  def run
  end

end