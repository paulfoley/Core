class CallbackController < ApplicationController

  skip_before_action :verify_authenticity_token
  respond_to :json
  require 'json'
  def receive_data
    render json:{}

    accounts = params[:message][:raw][:Account]
    events = params[:message][:events]

    # If the received JSON object contains account inforrmation
    if accounts != nil
      accounts.zip(events).each do |account, event|
        name = account[:Name]
        id = account[:Id]
        action = event[:eventType]
        element = event[:elementKey]

        output = SalesforceAccount.where(account_id: id).select(:account_id, :name).take

        if action == "CREATED"
          if output == nil
            Database.create_account(element, name, id)
          end

        elsif action == "DELETED"
          Database.delete_account(element, id)

        elsif action == "UPDATES"
          #Do change action

        end
      end
    end
  end
end
