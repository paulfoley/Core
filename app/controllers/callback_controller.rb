class CallbackController < ApplicationController

  skip_before_action :verify_authenticity_token
  respond_to :json
  require 'json'
  def receive_data
    render json:{}

    accounts = params[:message][:raw][:Account]
    events = params[:message][:events]
    if accounts != nil
      accounts.zip(events).each do |account, event|
        name = account[:Name]
        action = event[:eventType]
        element = event[:element]

        if action == "CREATED"
          Database.create_salesforce_account(name)
        end
      end
    end
  end
end
