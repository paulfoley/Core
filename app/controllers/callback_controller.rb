class CallbackController < ApplicationController

  skip_before_action :verify_authenticity_token
  respond_to :json
  require 'json'
  def receive_data
    render json:{}

    puts params
    accounts = params[:message][:raw][:Account]
    events = params[:message][:events]

    # If the received JSON object contains account information
    if accounts != nil
      accounts.zip(events).each do |account, event|

        action = event[:eventType]
        element = event[:elementKey]

        data = account

        output = SalesforceAccount.where(account_id: data[:Id]).select(:account_id, :name).take

        if action == "CREATED"
          if output == nil
            Database.create_account(element, data) #need to add org for account creation
          end

        elsif action == "DELETED"
          Database.delete_account(element, data)

        elsif action == "UPDATED"
          if output != nil
            Database.update_account(element, data)
          elsif output == nil
            Database.create_account(element, data)
          end
        end
      end
    end
  end
end
