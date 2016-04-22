class WelcomeController < ApplicationController

  def index
    session[:logged_in] = false
    if params[:view] == "login"
      @show_login = "show"
      @show_signup = ""
      @show_pw = ""
    elsif params[:view] == "signup"
      @show_login = ""
      @show_signup = "show"
      @show_pw = ""
    elsif params[:view] == "pw"
      @show_login = ""
      @show_signup = ""
      @show_pw = "show"
    else
      @show_login = "show"
      @show_signup = ""
      @show_pw = ""
    end
  end
  
  def check_user
    
    @email = params[:email]
    @password = params[:password]
    
    if User.exists?(email: @email)
      @user = User.find_by_email(@email)
      
      if @user.valid_password?(@password)
        login(@user)
        redirect_to controller:'core', action:'run'
      else 
        flash[:failure] = "Incorrect Password"
        redirect_to action:'index', view:'login'
      end
    else
      flash[:failure] = "Username not found"
      redirect_to action:'index', view:'login'
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
        redirect_to action:'index', view:'signup'
      else
        @org = Org.create(:name=>params[:org])
        @user = User.create(:name=>params[:firstname] + " " + params[:lastname], :email=>params[:email], :password=>params[:password1], :org=>@org, :is_admin=>true)
        #flash[:success] = "User created!"
        login(@user)
        redirect_to action:'setup'
      end
    end
  end
  
  def pw_mail
    PwMailer.pw_mail(params[:email]).deliver_now
    flash[:success] = "Email Sent"
    redirect_to :action=>'index'
  end
  
  def setup
    @org = Org.find_by(:name=>session[:org])
    if params[:view] == "link_apps"
      @show_apps = "show"
      @show_users = ""
    elsif params[:view] == "add_user"
      @show_apps = ""
      @show_users = "show"
    else 
      @show_apps = "show"
      @show_users = ""
    end
  end
  
  def add_user
    @org = Org.find_by(:name=>session[:org])
    @email1 = params[:email1]
    redirect_to controller:'core', action:'run'
  end
  
  def run
  end

end