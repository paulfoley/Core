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


  def oauth_url

  end

  def callback
    uri = URI.parse(@object.location)
    uri_params = CGI.parse(uri.query)
    @state = uri_params['state']
    redirect_to "http://corecloudapp.herokuapp.com/core/run"
    if @state == "sfdc"
      CloudElements.salesforce_instance(uri_params['code'])
    elsif @state == "quickbooks"
      CloudElements.quickbooks_instance(uri_params['oauth_token'], uri_params['oauth_verifier'], uri_params['realmId'], uri_params['dataSource'])
    end
  end

end