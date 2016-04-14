class CallbackController < ApplicationController

  skip_before_action :verify_authenticity_token
  respond_to :json

  def receive_data
    render json:{}


    data = params[:_json]
    puts data


    data.each do |account|
      Database.create_salesforce_account(account['Name'])


    end
  end
end
