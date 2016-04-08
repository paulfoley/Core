class ElementsController < ApplicationController

  def show
    response =  CloudElements.create_instance(params[:id])
    redirect_to response['oauthUrl']
    #render json: {stuff:'here'}
  end

  def callback
    # Step 3: get the params from the oauth callback
    # step 4: make another post to cloud elements
    # save the info somewhere
    # redirect the user to the admin ui

    puts "doing stuff here"
    render json: params
    #takes params from cloud elements
  end

end