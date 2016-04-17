class WelcomeController < ApplicationController

  def index
    if params[:view] == "login"
      @show_login = "show"
      @show_signup = ""
    elsif params[:view] == "signup"
      @show_login = ""
      @show_signup = "show"
    else 
      @show_login = "show"
      @show_signup = ""
    end
  end
  
  def check_user
    
    @email = params[:email]
    @password = params[:password]
    
    if User.exists?(email: @email)
      @user = User.find_by_email(@email)
      
      if @user.valid_password?(@password)
        redirect_to controller:'core', action:'run'
      else 
        flash[:failure] = "Incorrect Password"
        redirect_to action:'index', view:"login"
      end
    else
      flash[:failure] = "Username not found"
      redirect_to action:'index', view:"login"
    end
  end
  helper_method :check_user
  
  def signup
    @email = params[:email]
    #if params[:password1] != params[:password2]
      #flash[:notice] = "Mismatched Passwords"
    #else
    if User.exists?(email: @email)
      flash[:failure] = "User already exists"
      redirect_to action:'index', view:"signup"
    else
      @user = User.create(:name=>params[:username], :email=>params[:email], :password=>params[:password1])
      flash[:success] = "User created!"
      redirect_to action:'index', view:"login"
    end
  end
  
  def run
  end

end