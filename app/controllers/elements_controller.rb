class ElementsController < ApplicationController
  def show
    render json: CloudElements.create_instance(params[:id])
  end
  def callback
    #takes params from cloud elements
  end
end