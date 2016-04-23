class Database

  def self.create_org(name)
    if User.where(name: name).select(:name).take == nil
      Org.create(:name => name)
    end
  end

  def self.create_user(name, email, password, is_admin, org)
    if User.where(email: email).select(:email).take == nil
      User.create(:name => name, :email => email, :password => password, :is_admin => is_admin, :org => org)
    end
  end

  def self.delete_org(name)
    org = Org.where(name: name).select(:name, :id).take
    org.users.delete_all
    org.delete
  end

  def self.create_account(element, data, my_org)
    #Can be extended to other elements
    if element == "sfdc"
      account = SalesforceAccount.create(name: data[:Name], account_id: data[:Id], org: my_org)
      account.description = data[:Description]
      account.website = data[:Website]
      account.number_of_employees = data[:NumberOfEmployees]
      account.annual_revenue = data[:AnnualRevenue]
      account.industry = data[:Industry]
      account.type = data[:Type]
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

  def self.update_account(element, data)
    #Can be extended to other elements
    if element == "sfdc"
      SalesforceAccount.where(:account_id => data[:Id]).update_all(name: data[:Name])
      SalesforceAccount.where(:account_id => data[:Id]).update_all(description: data[:Description])
      SalesforceAccount.where(:account_id => data[:Id]).update_all(website: data[:Website])
      SalesforceAccount.where(:account_id => data[:Id]).update_all(number_of_employees: data[:NumberOfEmployees])
      SalesforceAccount.where(:account_id => data[:Id]).update_all(annual_revenue: data[:AnnualRevenue])
      SalesforceAccount.where(:account_id => data[:Id]).update_all(industry: data[:Industry])
      SalesforceAccount.where(:account_id => data[:Id]).update_all(type: data[:Type])
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

  def self.delete_account(element, data)
  #TODO Add logic to delete child instances to avoid orphans
  #Can be extended to other elements
    if element == "sfdc"
      SalesforceAccount.where(account_id: data[:Id]).delete_all
    else
      # create another type of account here
    end
  end

  def self.create_customer(element, data, my_org)
    #Can be extended to other elements
    if element == "quickbooks"

      puts "************"
      puts data[:companyName]
      customer = QuickbooksCustomer.create(name: data[:companyName], account_id: data[:id], org: my_org)
      customer.display_name = data[:displayName]
      customer.company_name = data[:companyName]
      customer.fully_qualified_name = data[:fullyQualifiedName]
      customer.print_on_check_name = data[:printOnCheckName]
      customer.domain = data[:domain]
      customer.taxable = data[:taxable]
      customer.active = data[:active]
      customer.balance = data[:balance]
      customer.balance_with_jobs = data[:balanceWithJobs]
      customer.save
    else
      # create another type of account here
    end
  end

  def self.update_customer(element, data)

  end

  def self.delete_customer(element, data)

  end
end
