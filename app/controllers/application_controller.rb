class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #http_basic_authenticate_with name: ENV['BASIC_AUTH_USERNAME'], password: ENV['BASIC_AUTH_PASSWORD']
  def login(user)
    @user = user
    session[:name] = @user.name
    session[:email] = @user.email
    session[:org] = @user.org.name
    session[:logged_in] = true
    session[:is_admin] = @user.is_admin
  end
  helper_method :login
    
  def logout
    session[:name] = nil
    session[:email] = nil
    session[:org] = nil
    session[:logged_in] = false
    session[:is_admin] = nil
  end
  helper_method :logout

end
