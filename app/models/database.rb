class Database

  # Create a new Org
  def self.create_org(name)
    if User.where(name: name).select(:name).take == nil
      Org.create(:name => name)
    end
  end

  # Delete an existing Org and its child entities
  def self.delete_org(name)
    org = Org.where(name: name).select(:name, :id).take

    # Delete each User associate with this Org
    org.users.each do |user|
      self.delete_user(user.email)
    end

    # Delete each account associate with this Org
    org.salesforce_account.each do |account|
      self.delete_account_id("sfdc", account.account_id)
    end

    # Delete each account associate with this Org
    org.quickbooks_customer.each do |customer|
      self.delete_customer_id("quickbooks", customer.customer_id)
    end

    org.delete
  end

  # Create a new User
  def self.create_user(name, email, password, is_admin, org)
    if User.where(email: email).select(:email).take == nil
      User.create(:name => name, :email => email, :password => password, :is_admin => is_admin, :org => org)
    end
  end

  # Delete an existing User
  def self.delete_user(email)
    user = User.where(email: email).select(:name, :id, :email).take
    user.delete
  end

  # Create a new account from hashed parameters
  # Currently only creates SalesforceAccount
  def self.create_account(element, data, org)
    #Can be extended to other elements
    if element == "sfdc"
      account = SalesforceAccount.create(name: data[:Name], org: org)
      account.account_id = data[:Id]
      account.description = data[:Description]
      account.website = data[:Website]
      account.number_of_employees = data[:NumberOfEmployees]
      account.annual_revenue = data[:AnnualRevenue]
      account.industry = data[:Industry]
      account.account_type = data[:Type]
      account.phone = data[:Phone]
      account.fax = data[:Fax]
      account.billing_country = data[:BillingCountry]
      account.billing_state = data[:BillingState]
      account.billing_city = data[:BillingCity]
      account.billing_postal_code = data[:BillingPostalCode]
      account.billing_street = data[:BillingStreet]
      account.shipping_country = data[:ShippingCountry]
      account.shipping_state = data[:ShippingState]
      account.shipping_city = data[:ShippingCity]
      account.shipping_postal_code = data[:ShippingPostalCode]
      account.shipping_street = data[:ShippingStreet]
      account.save
    else
      # create another type of account here
    end
  end

  # Update an existing account from hashed parameters
  def self.update_account(element, data)
    #Can be extended to other elements
    if element == "sfdc"
      SalesforceAccount.where(:account_id => data[:Id]).update_all(name: data[:Name])
      SalesforceAccount.where(:account_id => data[:Id]).update_all(description: data[:Description])
      SalesforceAccount.where(:account_id => data[:Id]).update_all(website: data[:Website])
      SalesforceAccount.where(:account_id => data[:Id]).update_all(number_of_employees: data[:NumberOfEmployees])
      SalesforceAccount.where(:account_id => data[:Id]).update_all(annual_revenue: data[:AnnualRevenue])
      SalesforceAccount.where(:account_id => data[:Id]).update_all(industry: data[:Industry])
      SalesforceAccount.where(:account_id => data[:Id]).update_all(account_type: data[:Type])
      SalesforceAccount.where(:account_id => data[:Id]).update_all(phone: data[:Phone])
      SalesforceAccount.where(:account_id => data[:Id]).update_all(fax: data[:Fax])
      SalesforceAccount.where(:account_id => data[:Id]).update_all(billing_country: data[:BillingCountry])
      SalesforceAccount.where(:account_id => data[:Id]).update_all(billing_state: data[:BillingState])
      SalesforceAccount.where(:account_id => data[:Id]).update_all(billing_city: data[:BillingCity])
      SalesforceAccount.where(:account_id => data[:Id]).update_all(billing_postal_code: data[:BillingPostalCode])
      SalesforceAccount.where(:account_id => data[:Id]).update_all(billing_street: data[:BillingStreet])
      SalesforceAccount.where(:account_id => data[:Id]).update_all(shipping_country: data[:ShippingCountry])
      SalesforceAccount.where(:account_id => data[:Id]).update_all(shipping_state: data[:ShippingState])
      SalesforceAccount.where(:account_id => data[:Id]).update_all(shipping_city: data[:ShippingCity])
      SalesforceAccount.where(:account_id => data[:Id]).update_all(shipping_postal_code: data[:ShippingPostalCode])
      SalesforceAccount.where(:account_id => data[:Id]).update_all(shipping_street: data[:BillingStreet])
    end
  end

  # Delete an existing account from hashed paramters
  # TODO Logic to delete child elements
  def self.delete_account(element, data)
  #Can be extended to other elements
    if element == "sfdc"
      self.delete_account_id(element, data[:Id])
    else
      # delete another type of account here
    end
  end

  # Delete an existing account from account_id
  # TODO Logic to delete child elements
  def self.delete_account_id(element, account_id)
    #Can be extended to other elements
    if element == "sfdc"
      SalesforceAccount.where(account_id: account_id).delete_all
    else
      # delete another type of account here
    end
  end

  # Create a new customer from hashed parameters
  # Currently only creates QuickbooksCustomer
  def self.create_customer(element, data, org)
    # Can be extended to other elements
    if element == "quickbooks"

      customer = QuickbooksCustomer.create(name: data[:companyName], org: org)
      customer.customer_id = data[:id]
      customer.display_name = data[:displayName]
      customer.fully_qualified_name = data[:fullyQualifiedName]
      customer.print_on_check_name = data[:printOnCheckName]
      customer.domain = data[:domain]
      customer.taxable = data[:taxable]
      customer.active = data[:active]
      customer.balance = data[:balance]
      customer.balance_with_jobs = data[:balanceWithJobs]
      customer.save
    else
      # create another type of customer here
    end
  end

  # Update an existing customer from hashed parameters
  def self.update_customer(element, data)
    #Can be extended to other elements
    if element == "quickbooks"
      QuickbooksCustomer.where(:customer_id => data[:id]).update_all(name: data[:companyName])
      QuickbooksCustomer.where(:customer_id => data[:id]).update_all(display_name: data[:displayName])
      QuickbooksCustomer.where(:customer_id => data[:id]).update_all(fully_qualified_name: data[:fullyQualifiedName])
      QuickbooksCustomer.where(:customer_id => data[:id]).update_all(print_on_check_name: data[:printOnCheckName])
      QuickbooksCustomer.where(:customer_id => data[:id]).update_all(domain: data[:domain])
      QuickbooksCustomer.where(:customer_id => data[:id]).update_all(taxable: data[:taxable])
      QuickbooksCustomer.where(:customer_id => data[:id]).update_all(active: data[:active])
      QuickbooksCustomer.where(:customer_id => data[:id]).update_all(balance: data[:balance])
      QuickbooksCustomer.where(:customer_id => data[:id]).update_all(balance_with_jobs: data[:balanceWithJobs])
    end
  end

  # Delete an existing account from hashed parameters
  # TODO Logic to delete child elements
  def self.delete_customer(element, data)
    #Can be extended to other elements
    if element == "quickbooks"
      self.delete_customer_id(element, data[:id])
    else
      # delete another type of customer here
    end
  end

  # Delete an existing customer from customer_id
  # TODO Logic to delete child elements
  def self.delete_customer_id(element, customer_id)
    #Can be extended to other elements
    if element == "quickbooks"
      QuickbooksCustomer.where(customer_id: customer_id).delete_all
    else
      # delete another type of account here
    end
  end

  # Create a new opportunity from hashed parameters
  # Currently only creates SalesforceOpportunity
  def self.create_opportunity(element, data, account)
    # TODO
  end

  # Update an existing opportunity from hashed parameters
  def self.update_opportunity(element, data)
    # TODO
  end

  # Delete an existing opportunity
  def self.delete_opportunity(element, data)
    # TODO
  end

  # Create a new invoice from hashed parameters
  # Currently only creates QuickbooksInvoice
  def self.create_invoice(element, data, customer)
    # TODO
  end

  # Update an existing invoice from hashed parameters
  def self.update_invoice(element, data)
    # TODO
  end

  # Delete an existing invoice
  def self.delete_invoice(element, data)
    # TODO
  end

end
