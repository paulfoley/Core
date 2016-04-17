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
    if @state == "sfdc"
      CloudElements.salesforce_instance(code)
    elsif @state == "quickbooks"
      CloudElements.quickbooks_instance(oauth_token, oauth_verifier, realmId, dataSource)
    end

    puts "doing stuff here"
    render json: params
    #takes params from cloud elements
  end

end