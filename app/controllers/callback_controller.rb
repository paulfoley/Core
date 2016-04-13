class CallbackController < ApplicationController

  skip_before_action :verify_authenticity_token

  def receive_data

    #payload = JSON.parse(request.body)
    #puts payload

    payload  = response.body.to_json
    payload = JSON.parse(payload)
    puts payload
  end
end
