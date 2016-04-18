class ElementsController < ApplicationController

  require 'cgi'
  require 'uri'

  def show
    @app = params[:app_name]
    if @app == "a_CRM"
      redirect_to CloudElements.salesforce_oauthurl
    elsif @app == "a_accounting"
      redirect_to CloudElements.quickbooks_oauthtoken
    end
  end


  def callback
    @uri_params = params
#    redirect_to "http://corecloudapp.herokuapp.com/core/run"
    @state = @uri_params[:state]
    if @state == "sfdc"
      CloudElements.salesforce_instance(session[:org], @uri_params[:code])
      @var = Org.where(name: session[:org]).select(:salesforce_token).take
    elsif @state == "quickbooks"
      CloudElements.quickbooks_instance(session[:org], @uri_params[:oauth_token], @uri_params[:oauth_verifier], @uri_params[:realmId], @uri_params[:dataSource])
      @var = Org.where(name: session[:org]).select(:quickbooks_token).take
    end


  end

end