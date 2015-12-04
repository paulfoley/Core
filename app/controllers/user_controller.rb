class UserController < ApplicationController

  def list
    @user = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
  end

  def read
    @user = User.find(params[:email])
  end

  def update
    @user = User.find(params[:email])
  end

  def delete
    @user = User.find(params[:email]).destroy
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :payload)
  end
end
