class WelcomeController < ApplicationController

  def index
    session[:logged_in] = false
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
        session[:name] = @user.name
        session[:email] = @email
        session[:org] = @user.org.name
        session[:logged_in] = true
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
    
    if Org.exists?(name: params[:org])
      flash[:failure] = "Organization already exists"
      redirect_to action:'index', view:'signup'
    else
      @email = params[:email]
      if User.exists?(email: @email)
        flash[:failure] = "A user with that email already exists"
        redirect_to action:'index', view:"signup"
      else
        @org = Org.create(:name=>params[:org])
        @user = User.create(:name=>params[:firstname]+" "+params[:lastname], :email=>params[:email], :password=>params[:password1], :org=>@org, :is_admin=>true)
        flash[:success] = "User created!"
        redirect_to action:'index', view:"login"
      end
    end
  end
  
  def login
  end
  
  def logout
  end
  
  def run
  end

end