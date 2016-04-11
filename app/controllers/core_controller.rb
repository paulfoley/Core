class CoreController < ApplicationController
  def run
  end

  def login
  end

  def show
    @cust = QuickbooksCustomer.first
  end




end
