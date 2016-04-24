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
    #Can be extended to other elements
    if element == "sfdc"
      opportunity = SalesforceOpportunity.create(opportunity_id: data[:Id], salesforce_account: account, org_id: account.org_id)
      opportunity.description = data[:Description]
      opportunity.forecast_category = data[:ForecastCategory]
      opportunity.last_referenced_date = data[:LastReferencedDate]
      opportunity.close_date = data[:CloseDate]
      opportunity.name = data[:Name]
      opportunity.stage_name = data[:StageName]
      opportunity.last_viewed_date = data[:LastViewedDate]
      opportunity.fiscal = data[:Fiscal]
      opportunity.opportunity_type = data[:Type]
      opportunity.lead_source = data[:LeadSource]
      opportunity.forecast_category_name = data[:ForecastCategoryName]
      opportunity.last_modified_by_id = data[:LastModifiedById]
      opportunity.next_step = data[:NextStep]
      opportunity.probability = data[:Probability]
      opportunity.fiscal_quarter = data[:FiscalQuarter]
      opportunity.fiscal_year = data[:FiscalYear]
      opportunity.amount = data[:Amount]
      opportunity.is_won = data[:IsWon]
      opportunity.is_deleted = data[:IsDeleted]
      opportunity.has_opportunity_line_item = data[:HasOpportunityLineItem]
      opportunity.is_closed = data[:IsClosed]
      opportunity.account_id = data[:AccountID]
      opportunity.save
    else
      # create another type of account here
    end
  end

  # Update an existing opportunity from hashed parameters
  def self.update_opportunity(element, data)
    #Can be extended to other elements
    if element == "sfdc"
      SalesforceOpportunity.where(:opportunity_id => data[:Id]).update_all(description: data[:Description])
      SalesforceOpportunity.where(:opportunity_id => data[:Id]).update_all(forecast_category: data[:ForecastCategory])
      SalesforceOpportunity.where(:opportunity_id => data[:Id]).update_all(last_referenced_date: data[:LastReferencedDate])
      SalesforceOpportunity.where(:opportunity_id => data[:Id]).update_all(close_date: data[:CloseDate])
      SalesforceOpportunity.where(:opportunity_id => data[:Id]).update_all(name: data[:Name])
      SalesforceOpportunity.where(:opportunity_id => data[:Id]).update_all(stage_name: data[:StageName])
      SalesforceOpportunity.where(:opportunity_id => data[:Id]).update_all(last_viewed_date: data[:LastViewedDate])
      SalesforceOpportunity.where(:opportunity_id => data[:Id]).update_all(fiscal: data[:Fiscal])
      SalesforceOpportunity.where(:opportunity_id => data[:Id]).update_all(opportunity_type: data[:Type])
      SalesforceOpportunity.where(:opportunity_id => data[:Id]).update_all(lead_source: data[:LeadSource])
      SalesforceOpportunity.where(:opportunity_id => data[:Id]).update_all(forecast_category_name: data[:ForecastCategoryName])
      SalesforceOpportunity.where(:opportunity_id => data[:Id]).update_all(last_modified_by_id: data[:LastModifiedById])
      SalesforceOpportunity.where(:opportunity_id => data[:Id]).update_all(next_step: data[:NextStep])
      SalesforceOpportunity.where(:opportunity_id => data[:Id]).update_all(probability: data[:Probability])
      SalesforceOpportunity.where(:opportunity_id => data[:Id]).update_all(fiscal_quarter: data[:FiscalQuarter])
      SalesforceOpportunity.where(:opportunity_id => data[:Id]).update_all(fiscal_year: data[:FiscalYear])
      SalesforceOpportunity.where(:opportunity_id => data[:Id]).update_all(amount: data[:Amount])
      SalesforceOpportunity.where(:opportunity_id => data[:Id]).update_all(is_won: data[:IsWon])
      SalesforceOpportunity.where(:opportunity_id => data[:Id]).update_all(is_deleted: data[:IsDeleted])
      SalesforceOpportunity.where(:opportunity_id => data[:Id]).update_all(has_opportunity_line_item: data[:HasOpportunityLineItem])
      SalesforceOpportunity.where(:opportunity_id => data[:Id]).update_all(is_closed: data[:IsClosed])
      SalesforceOpportunity.where(:opportunity_id => data[:Id]).update_all(account_id: data[:AccountID])
    end
  end

  # Delete an existing opportunity from hashed parameters
  def self.delete_opportunity(element, data)
    #Can be extended to other elements
    if element == "sfdc"
      self.delete_opportunity_id(element, data[:Id])
    else
      # delete another type of invoice here
    end
  end

  # Delete an existing opportunity from opportunity_id
  def self.delete_opportunity_id(element, opportunity_id)
    #Can be extended to other elements
    if element == "sfdc"
      SalesforceOpportunity.where(opportunity_id: opportunity_id).delete_all
    else
      # delete another type of account here
    end
  end

  # Create a new invoice from hashed parameters
  # Currently only creates QuickbooksInvoice
  def self.create_invoice(element, data, customer)
    #Can be extended to other elements
    if element == "quickbooks"
      invoice = QuickbooksInvoice.create(invoice_id: data[:id], quickbooks_customer: customer, org_id: customer.org_id)
      invoice.sync_token = data[:syncToken]
      invoice.doc_number = data[:docNumber]
      invoice.due_date = data[:dueDate]
      invoice.print_status = data[:printStatus]
      invoice.email_status = data[:emailStatus]
      invoice.domain = data[:domain]
      invoice.txn_date = data[:txnDate]
      invoice.balance = data[:balance]
      invoice.total_amt = data[:totalAmt]
      invoice.allow_online_ach_payment = data[:allowOnlineACHPayment]
      invoice.allow_online_payment = data[:allowOnlinePayment]
      invoice.allow_ipn_payment = data[:allowIPNPayment]
      invoice.apply_tax_after_discount = data[:applyTaxAfterDiscount]
      invoice.allow_online_credit_card_payment = data[:allowOnlineCreditCardPayment]
      invoice.sparse = data[:sparse]
      invoice.save
    else
      # create another type of account here
    end
  end

  # Update an existing invoice from hashed parameters
  def self.update_invoice(element, data)
    #Can be extended to other elements
    if element == "quickbooks"
      QuickbooksInvoice.where(:invoice_id => data[:id]).update_all(sync_token: data[:syncToken])
      QuickbooksInvoice.where(:invoice_id => data[:id]).update_all(doc_number: data[:docNumber])
      QuickbooksInvoice.where(:invoice_id => data[:id]).update_all(due_date: data[:dueDate])
      QuickbooksInvoice.where(:invoice_id => data[:id]).update_all(print_status: data[:printStatus])
      QuickbooksInvoice.where(:invoice_id => data[:id]).update_all(email_status: data[:emailStatus])
      QuickbooksInvoice.where(:invoice_id => data[:id]).update_all(domain: data[:domain])
      QuickbooksInvoice.where(:invoice_id => data[:id]).update_all(txn_date: data[:txnDate])
      QuickbooksInvoice.where(:invoice_id => data[:id]).update_all(balance: data[:balance])
      QuickbooksInvoice.where(:invoice_id => data[:id]).update_all(total_amt: data[:totalAmt])
      QuickbooksInvoice.where(:invoice_id => data[:id]).update_all(allow_online_ach_payment: data[:allowOnlineACHPayment])
      QuickbooksInvoice.where(:invoice_id => data[:id]).update_all(allow_online_payment: data[:allowOnlinePayment])
      QuickbooksInvoice.where(:invoice_id => data[:id]).update_all(allow_ipn_payment: data[:allowIPNPayment])
      QuickbooksInvoice.where(:invoice_id => data[:id]).update_all(apply_tax_after_discount: data[:applyTaxAfterDiscount])
      QuickbooksInvoice.where(:invoice_id => data[:id]).update_all(allow_online_credit_card_payment: data[:allowOnlineCreditCardPayment])
      QuickbooksInvoice.where(:invoice_id => data[:id]).update_all(sparse: data[:sparse])
    end
  end

  # Delete an existing invoice from hashed parameters
  def self.delete_invoice(element, data)
    #Can be extended to other elements
    if element == "quickbooks"
      self.delete_invoice_id(element, data[:id])
    else
      # delete another type of invoice here
    end
  end

  # Delete an existing invoice from invoice_id
  def self.delete_invoice_id(element, invoice_id)
    #Can be extended to other elements
    if element == "quickbooks"
      QuickbooksInvoice.where(invoice_id: invoice_id).delete_all
    else
      # delete another type of account here
    end
  end

  #TODO
  def self.create_paymernt(element, data, customer)

  end

  #TODO
  def self.update_payment(element, data)

  end

  #TODO
  def self.delete_payment(element, data)

  end

  #TODO
  def self.delete_payment_id(element, payment_id)

  end

  #TODO
  def self.create_contact(element, data, account)

  end

  #TODO
  def self.update_contact(element, data)

  end

  #TODO
  def self.delete_contact(element, data)

  end

  #TODO
  def self.delete_contact_id(element, payment_id)

  end

  #TODO
  def self.create_lead(element, data, account)

  end

  #TODO
  def self.update_lead(element, data)

  end

  #TODO
  def self.delete_lead(element, data)

  end

  #TODO
  def self.delete_lead_id(element, payment_id)

  end
end
