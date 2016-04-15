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
        action = event[:eventType]
        element = event[:elementKey]

        if action == "CREATED"
          Database.create_account(element, name)

        elsif action == "DELETED"
          #Do delete action
          Database.delete_account(element, name)
        elsif action == "CHANGED"
          #Do change action

        end
      end
    end
  end
end
