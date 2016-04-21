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

  def self.create_account(element, data)

    if element == "sfdc"
      account = SalesforceAccount.create(name: data[:Name], account_id: data[:Id]) #need to include org in creation
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

    elsif element == "quickbooks"
      account = QuickbooksAccount.create(name: data[:Name], account_id: data[:Id])
    end

  end

  def self.delete_account(element, data)

    if element == "sfdc"
      SalesforceAccount.where(account_id: data[:Id]).delete_all
    end

  end

  def self.update_account(element, data)

    if element == "sfdc"
      SalesforceAccount.where(:account_id => data[:Id]).update_all(name: data[1])

    end

  end
end
