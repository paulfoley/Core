class CallbackController < ApplicationController

  skip_before_action :verify_authenticity_token
  respond_to :json
  require 'json'
  def receive_data
    render json:{}

    message = params[:message]
    raw = message[:raw]
    account = raw[:Account]
    events = message[:events]
    name = account[0][:Name]
    action = events[0][:eventType]

    if action == "CREATED"
      Database.create_salesforce_account(name)
    end

  end
end
