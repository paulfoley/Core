class UserController < ApplicationController

  def index
    @user = User.all
  end

  def show
    @user = User.find(params[:email])
  end

  def update
    @user = User.find(params[:email])
  end

  def destroy
    @user = User.find(params[:email]).destroy
  end

end
