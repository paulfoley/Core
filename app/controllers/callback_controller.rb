class CallbackController < ApplicationController

  skip_before_action :verify_authenticity_token
  respond_to :json
  require 'json'
  def receive_data
    render json:{}

    events = params[:message][:events]
    object = params[:message][:raw][:objectType]

    # If the received JSON object contains account information
    if object == "Account"

      accounts = params[:message][:raw][:Account]
      accounts.zip(events).each do |account, event|

        action = event[:eventType]
        element = event[:elementKey]
        instance = params[:message][:instanceId]
        data = account
        puts instance

        org = Org.where(salesforce_instance_id: instance).select(:name, :id).take

        output = SalesforceAccount.where(account_id: data[:Id]).select(:account_id, :name).take

        if action == "CREATED"
          if output == nil
            Database.create_account(element, data, org)
          end

        elsif action == "DELETED"
          Database.delete_account(element, data)

        elsif action == "UPDATED"
          if output != nil
            Database.update_account(element, data)
          elsif output == nil
            Database.create_account(element, data, org)
          end
        end
      end

    elsif object == "customers"

      customers = params[:message][:raw][:customers]
      customers.zip(events).each do |customer, event|

        action = event[:eventType]
        element = event[:elementKey]
        instance = params[:message][:instanceId]
        data = customer

        org = Org.where(quickbooks_instance_id: instance).select(:name, :id).take

        output = QuickbooksCustomer.where(account_id: data[:id]).select(:account_id, :name).take

        if action == "CREATED"
          if output == nil
            Database.create_customer(element, data, org)
          end

        elsif action == "DELETED"
          Database.delete_customer(element, data)

        elsif action == "UPDATED"
          if output != nil
            Database.update_customer(element, data)
          elsif output == nil
            Database.create_customer(element, data, org)
          end
        end
      end
    end
  end
end
