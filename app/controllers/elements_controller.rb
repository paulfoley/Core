class ElementsController < ApplicationController

  require 'cgi'
  require 'uri'

  def show
    @org_name = session[:org]
    @app = params[:app_name]
    if @app == "link_CRM" || @app == "a_CRM"
      if Org.where(name: @org_name).select(:salesforce_token).take.salesforce_token
        flash[:failure] = "You have already connected a Salesforce account to Core"
      elsif
      redirect_to CloudElements.salesforce_oauthurl
      end
    elsif @app == "link_accounting" || @app == "a_accounting"
      if Org.where(name: @org_name).select(:quickbooks_token).take.quickbooks_token
        flash[:failure] = "You have already connected a Quickbooks account to Core"
      elsif
      redirect_to CloudElements.quickbooks_oauthtoken
      end
    elsif @app == "link_ecommerce" || @app == "a_ecommerce"
      if Org.where(name: @org_name).select(:stripe_token).take.stripe_token
        flash[:failure] = "You have already connected a Stripe account to Core"
      elsif
      redirect_to "https://connect.stripe.com/oauth/authorize?response_type=code&client_id=ca_84qPNMWLjrw7mUSm1MMKofy3ChAglggB&scope=read_write"
      end
    end

  end


  def callback
    @uri_params = params
    redirect_to "https://corecloudapp.herokuapp.com/core/run"
    @state = @uri_params[:state]
    if @state == "sfdc"
      CloudElements.salesforce_instance(session[:org], @uri_params[:code])
      @var = Org.where(name: session[:org]).select(:salesforce_token).take.salesforce_token
    elsif @state == "quickbooks"
      CloudElements.quickbooks_instance(session[:org], @uri_params[:oauth_token], @uri_params[:oauth_verifier], @uri_params[:realmId], @uri_params[:dataSource])
      @var = Org.where(name: session[:org]).select(:quickbooks_token).take.quickbooks_token
    end

  end

  def stripe_callback
    @uri_params = params
    redirect_to "https://corecloudapp.herokuapp.com/core/run"
    CloudElements.stripe_oauth(@uri_params[:code])
  end

end