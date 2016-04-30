class CoreController < ApplicationController
  before_action :require_login
  #private
  
  def run
    #variables available in main view
    @user = User.find_by(email: session[:email])
    @org = Org.find_by(name: session[:org])
    #for app logo b/w
    @connected_to_salesforce = !!@org.salesforce_token
    @connected_to_quickbooks = !!@org.quickbooks_token
    @connected_to_stripe = !!@org.stripe_token
    #variables for highcharts
    @customer_count = SalesforceAccount.count(:conditions=>'org_id = @org.id')
    @opportunity_count = SalesforceOpportunity.count(:conditions=>'org_id = @org.id')
    @open_invoices_count = QuickbooksInvoice.count(:conditions=>'org_id = @org.id AND is_active = TRUE')
    
    #pull data for main graph
    @invoices = Array.new(30)
    if QuickbooksInvoice.count(:conditions=>'org_id = @org.id') > 0
      QuickbooksInvoice.all.each do |f|
        if f.date_created.month == Time.now.month
          @invoices[f.date_created.day-1] = @invoices[f.date_created.day-1].to_f + f.total_amt.to_f
        end
      end
    end
    if QuickbooksPayment.count(:conditions=>'org_id = @org.id') > 0
      @payments = Array.new(30)
      QuickbooksPayment.all.each do |f|
        if f.date_created.month == Time.now.month
          @payments[f.date_created.day-1] = @payments[f.date_created.day-1].to_f + f.total_amt.to_f
        end
      end
    end
    
    #variables for use in JS
    gon.push({
      :user=>@user,
      :org=>@org,
      :connected_to_salesforce=>@connected_to_salesforce,
      :connected_to_quickbooks=>@connected_to_quickbooks,
      :connected_to_stripe=>@connected_to_stripe,
      :invoices=>@invoices,
      :payments=>@payments
    })

    if @connected_to_salesforce
      CloudElements.get_salesforce_reports(session[:org])
    end

  end
  
  def change_settings
    @user = User.find_by(email: session[:email])
    if params[:name] != ""
      @user.name = params[:name]
      session[:name] = params[:name]
    end
    if params[:email] != ""
      @user.email = params[:email]
      session[:email] = params[:email]
    end
    if params[:position] != ""
      @user.position = params[:position]
      session[:position] = params[:position]
    end
    @user.save
    redirect_to :back
  end
  
  #same as welcome controller invite_user, could probably be merged into application controller
  def invite_user
    @org = Org.find_by(:name=>session[:org])
    @org_name = @org.name
    @email = params[:email]
    InviteMailer.invite_mail(@email,@org_name).deliver_now
    flash[:success] = "User Invited!"
    redirect_to :back
  end
  
  def logout
    session[:logged_in] = false
    flash[:failure] = "Logged Out"
    redirect_to controller:'welcome', action:'index'
  end
  
  #prevent access to app without login
  def require_login
    if !session[:logged_in]
      flash[:failure] = "You must be logged in to access CORE"
      redirect_to controller:'welcome', action:'index'
    end
  end


end
