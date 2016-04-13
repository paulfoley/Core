class CallbackController < ApplicationController

  skip_before_action :verify_authenticity_token
  respond_to :json

  def receive_data

    payload  = response.body.to_json
    payload = JSON.parse(payload)
    puts payload
  end
end
