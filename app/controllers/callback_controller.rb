class CallbackController < ApplicationController

  skip_before_action :verify_authenticity_token
  respond_to :json
  require 'json'
  def receive_data
    render json:{}

    @events = params[:message][:events]
    @object = params[:message][:raw][:objectType]

    # Perform the action based on the type of object being modified
    if @object == "Account"
      do_account
    elsif @object == "customers"
      do_customer
    elsif @object == "invoices"
      do_invoice
    elsif @object == "Opportunity"
      do_opportunity
    end
  end

  # Process Account events
  def do_account
    accounts = params[:message][:raw][:Account]
    accounts.zip(@events).each do |account, event|

      action = event[:eventType]
      element = event[:elementKey]
      instance = params[:message][:instanceId]
      data = account

      org = Org.where(salesforce_instance_id: instance).select(:name, :id).take

      output = SalesforceAccount.where(account_id: data[:Id]).select(:account_id, :name).take

      if action == "CREATED"
        if output == nil
          Database.create_account(element, data, org)
        end

      elsif action == "DELETED"
        Database.delete_account(element, data)

      elsif action == "UPDATED"
        if output != nil
          Database.update_account(element, data)
        elsif output == nil
          Database.create_account(element, data, org)
        end
      end
    end
  end

  # Process Customer events
  def do_customer
    customers = params[:message][:raw][:customers]
    customers.zip(@events).each do |customer, event|

      action = event[:eventType]
      element = event[:elementKey]
      instance = params[:message][:instanceId]
      data = customer

      org = Org.where(quickbooks_instance_id: instance).select(:name, :id).take

      output = QuickbooksCustomer.where(customer_id: data[:id]).select(:customer_id, :name).take

      if action == "CREATED"
        if output == nil
          Database.create_customer(element, data, org)
        end

      elsif action == "DELETED"
        Database.delete_customer(element, data)

      elsif action == "UPDATED"
        if output != nil
          Database.update_customer(element, data)
        elsif output == nil
          Database.create_customer(element, data, org)
        end
      end
    end
  end

  # Process Invoice Events
  def do_invoice
    invoices = params[:message][:raw][:invoices]
    invoices.zip(@events).each do |invoice, event|

      action = event[:eventType]
      element = event[:elementKey]
      customer_id = invoice[:customerRef][:value]
      customer_name = invoice[:customerRef][:name]

      data = invoice

      customer = QuickbooksCustomer.where(name: customer_name).select(:name, :id).take

      output = QuickbooksInvoice.where(invoice_id: data[:id]).select(:invoice_id).take

      if action == "CREATED"
        if output == nil
          Database.create_invoice(element, data, customer)
        end

      elsif action == "DELETED"
        Database.delete_invoice(element, data)

      elsif action == "UPDATED"
        if output != nil
          Database.update_invoice(element, data)
        elsif output == nil
          Database.create_invoice(element, data, customer)
        end
      end
    end
  end

  # Process Opportunity Events
  def do_opportunity

  end
end
