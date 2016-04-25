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
    org.salesforce_accounts.each do |account|
      self.delete_account_id("sfdc", account.account_id)
    end

    # Delete each lead associate with this Org
    org.salesforce_leads.each do |lead|
      self.delete_lead_id("sfdc", lead.lead_id)
    end

    # Delete each account associate with this Org
    org.quickbooks_customers.each do |customer|
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
  def self.delete_account(element, data)
  #Can be extended to other elements
    if element == "sfdc"
      self.delete_account_id(element, data[:Id])
    else
      # delete another type of account here
    end
  end

  # Delete an existing account from account_id
  def self.delete_account_id(element, account_id)
    #Can be extended to other elements
    if element == "sfdc"
      account = SalesforceAccount.where(account_id: account_id).select(:name, :id).take

      # Delete contacts associated with this Account
      account.salesforce_contacts.each do |contact|
        self.delete_contact_id("sfdc", contact.contact_id)
      end

      # Delete opportunities associated with this Account
      account.salesforce_opportunities.each do |opportunity|
        self.delete_opportunity_id("sfdc", opportunity.opportunity_id)
      end

      account.delete

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
  def self.delete_customer(element, data)
    #Can be extended to other elements
    if element == "quickbooks"
      self.delete_customer_id(element, data[:id])
    else
      # delete another type of customer here
    end
  end

  # Delete an existing customer from customer_id
  def self.delete_customer_id(element, customer_id)
    #Can be extended to other elements
    if element == "quickbooks"
      customer = QuickbooksCustomer.where(customer_id: customer_id).select(:name, :id).take

      # Delete payments associated with this Customer
      customer.quickbooks_payments.each do |payment|
        self.delete_payment_id("quickbooks", payment.payment_id)
      end

      # Delete payments associated with this Customer
      customer.quickbooks_invoices.each do |invoice|
        self.delete_invoice_id("quickbooks", invoice.invoice_id)
      end

      customer.delete

    else
      # delete another type of account here
    end
  end

  # Create a new opportunity from hashed parameters
  # Currently only creates SalesforceOpportunity
  def self.create_opportunity(element, data, account)
    #Can be extended to other elements
    if element == "sfdc"
      opportunity = SalesforceOpportunity.create(opportunity_id: data[:Id], salesforce_account: account, org: account.org)
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
      invoice = QuickbooksInvoice.create(invoice_id: data[:id], quickbooks_customer: customer, org: customer.org)
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
      # delete another type of invoice here
    end
  end

  # Create a new payment from hashed parameters
  # Currently only creates QuickbooksPayment
  def self.create_payment(element, data, customer)
    #Can be extended to other elements
    if element == "quickbooks"
      payment = QuickbooksPayment.create(payment_id: data[:id], quickbooks_customer: customer, org: customer.org)
      payment.sync_token = data[:syncToken]
      payment.domain = data[:domain]
      payment.payment_ref_num = data[:paymentRefNum]
      payment.txn_date = data[:txnDate]
      payment.process_payments = data[:processPayments]
      payment.sparse = data[:sparse]
      payment.unapplied_amt = data[:unappliedAmt]
      payment.total_amt = data[:totalAmt]
      payment.save
    else
      # create another type of account here
    end
  end

  # TODO
  def self.update_payment(element, data)

  end

  # Delete an existing payment from hashed parameters
  def self.delete_payment(element, data)
    #Can be extended to other elements
    if element == "quickbooks"
      self.delete_payment_id(element, data[:id])
    else
      # delete another type of payment here
    end
  end

  # Delete an existing payment from payment_id
  def self.delete_payment_id(element, payment_id)
#Can be extended to other elements
    if element == "quickbooks"
      QuickbooksPayment.where(payment_id: payment_id).delete_all
    else
      # delete another type of pyament here
    end
  end

  # Create a new contact from hashed parameters
  # Currently only creates SalesforceContact
  def self.create_contact(element, data, account)
    #Can be extended to other elements
    if element == "sfdc"
      contact = SalesforceContact.create(contact_id: data[:Id], salesforce_account: account, org: account.org)
      contact.assistant_phone =data[:AssistantPhone]
      contact.other_phone =data[:OtherPhone]
      contact.account_id =data[:AccountId]
      contact.email =data[:Email]
      contact.description =data[:Description]
      contact.assistant_name =data[:AssistantName]
      contact.last_referenced_date =data[:LastReferenceDate]
      contact.salutation =data[:Salutation]
      contact.other_state =data[:OtherState]
      contact.mobile_phone =data[:MobilePhone]
      contact.name =data[:Name]
      contact.department =data[:Department]
      contact.created_by_id =data[:CreatedById]
      contact.owner_id =data[:OwnerId]
      contact.other_city =data[:OtherCity]
      contact.phone =data[:Phone]
      contact.other_country =data[:OtherCountry]
      contact.photo_url =data[:PhotoUrl]
      contact.first_name =data[:FirstName]
      contact.other_postal_code =data[:OtherPostalCode]
      contact.last_viewed_date =data[:LastViewedDate]
      contact.title =data[:Title]
      contact.birthdate =data[:Birthdate]
      contact.other_street =data[:OtherStreet]
      contact.lead_source =data[:LeadSource]
      contact.home_phone =data[:HomePhone]
      contact.reports_to_id =data[:ReportsToId]
      contact.created_date =data[:CreatedDate]
      contact.last_name =data[:LastName]
      contact.fax =data[:Fax]
      contact.is_deleted =data[:IsDeleted]
      contact.is_email_bounced =data[:IsEmailBounced]
      contact.save
    else
      # create another type of account here
    end
  end

  # TODO
  def self.update_contact(element, data)

  end

  # Delete an existing contact from hashed parameters
  def self.delete_contact(element, data)
    #Can be extended to other elements
    if element == "sfdc"
      self.delete_contact_id(element, data[:Id])
    else
      # delete another type of contact here
    end
  end

  # Delete an existing contact from contact_id
  def self.delete_contact_id(element, contact_id)
    #Can be extended to other elements
    if element == "sfdc"
      SalesforceContact.where(contact_id: contact_id).delete_all
    else
      # delete another type of contact here
    end
  end

  # Create a new lead from hashed parameters
  # Currently only creates SalesforceLead
  def self.create_lead(element, data, org)
    #Can be extended to other elements
    if element == "sfdc"
      lead = SalesforceLead.create(lead_id: data[:Id], org: org)
      lead.number_of_employees = data[:NumberOfEmployees]
      lead.company = data[:Company]
      lead.email = data[:Email]
      lead.description = data[:Description]
      lead.rating = data[:Rating]
      lead.postal_code = data[:PostalCode]
      lead.website = data[:Website]
      lead.last_referenced_date = data[:LastReferencedDate]
      lead.salutation = data[:Salutation]
      lead.name = data[:Name]
      lead.industry = data[:Industry]
      lead.created_by_id = data[:CreatedById]
      lead.owner_id = data[:OwnerId]
      lead.phone = data[:Phone]
      lead.street = data[:Street]
      lead.photo_url = data[:PhotoUrl]
      lead.status = data[:Status]
      lead.first_name = data[:FirstName]
      lead.last_viewed_date = data[:LastViewedDate]
      lead.title = data[:Title]
      lead.city = data[:City]
      lead.lead_source = data[:LeadSource]
      lead.state = data[:State]
      lead.created_date = data[:CreatedDate]
      lead.country = data[:Country]
      lead.last_name = data[:LastName]
      lead.last_modified_by_id = data[:LastModifiedById]
      lead.is_deleted = data[:IsDeleted]
      lead.is_converted = data[:IsConverted]
      lead.is_unread_by_owner = data[:IsUnreadByOwner]
      lead.annual_revenue = data[:AnnualRevenue]
      lead.save
    else
      # create another type of account here
    end
  end

  # TODO
  def self.update_lead(element, data)

  end

  # Delete an existing lead from hashed parameters
  def self.delete_lead(element, data)
    #Can be extended to other elements
    if element == "sfdc"
      self.delete_lead_id(element, data[:Id])
    else
      # delete another type of lead here
    end
  end

  # Delete an existing lead from lead_id
  def self.delete_lead_id(element, lead_id)
    #Can be extended to other elements
    if element == "sfdc"
      SalesforceLead.where(lead_id: lead_id).delete_all
    else
      # delete another type of lead here
    end
  end


  ## Methods for bulk import of data on first account conenction ##

  # Create multiple ccounts from hashed parameters when account is first connected
  # Currently only creates SalesforceAccounts
  def self.bulk_create_accounts(element, instance_id, data)
    if element == "sfdc"
      data.each do |account|
        org = Org.where(salesforce_instance_id: instance_id).select(:name, :id).take
        next if org == nil
        self.create_account(element, account, org)
      end
    else
      # Create another type of entity here
    end
  end

  # Create multiple leads from hashed parameters when account is first connected
  # Currently only creates SalesforceLeads
  def self.bulk_create_leads(element, instance_id, data)
    if element == "sfdc"
      data.each do |lead|
        org = Org.where(salesforce_instance_id: instance_id).select(:name, :id).take
        next if org == nil
        self.create_lead(element, lead, org)
      end
    else
      # Create another type of entity here
    end
  end

  # Create multiple contacts from hashed parameters when account is first connected
  # Currently only creates SalesforceContacts
  def self.bulk_create_contacts(element, instance_id, data)
    if element == "sfdc"
      data.each do |contact|
        account = SalesforceAccount.where(account_id: contact[:AccountId]).select(:account_id, :id, :org_id).take
        next if account == nil
        self.create_contact(element, contact, account)
      end
    else
      # Create another type of entity here
    end
  end

  # Create multiple opportunities from hashed parameters when account is first connected
  # Currently only creates SalesforceOpportunities
  def self.bulk_create_opportunities(element, instance_id, data)
    if element == "sfdc"
      data.each do |opportunity|
        account = SalesforceAccount.where(account_id: opportunity[:AccountId]).select(:account_id, :id, :org_id).take
        next if account == nil
        self.create_opportunity(element, opportunity, account)
      end
    else
      # Create another type of entity here
    end
  end

  # Create multiple customers from hashed parameters when account is first connected
  # Currently only creates QuickbooksCustomers
  def self.bulk_create_customers(element, instance_id, data)
    if element == "quickbooks"
      puts "***** In bulk_create_customers *****"
      data.each do |customer|
        puts "***** Output customer *****"
        puts customer
        org = Org.where(quickbooks_instance_id: instance_id).select(:name, :id).take
        next if org == nil
        self.create_customer(element, customer, org)
      end
    else
      # Create another type of entity here
    end
  end

  # Create multiple invoices from hashed parameters when account is first connected
  # Currently only creates QuickbooksInvoices
  def self.bulk_create_invoices(element, instance_id, data)
    if element == "quickbooks"
      puts "***** In bulk_create_invoices *****"
      data.each do |invoice|
        puts "***** Output invoice *****"
        puts invoice
        puts "***** Invoice in JSON *****"
        puts JSON.parse(invoice)
        puts "***** customerRef *****"
        puts invoice[:customerRef]
        # puts invoice[:customerRef][:name]
        puts "***** Skipping create invoice *****"
        # customer = QuickbooksCustomer.where(name: invoice[:customerRef][:name]).select(:customer_id, :id, :org_id).take
        #next if customer == nil
        #self.create_invoice(element, invoice, customer)
      end
    else
      # Create another type of entity here
    end
  end

  # Create multiple payments from hashed parameters when account is first connected
  # Currently only creates QuickbooksPayments
  def self.bulk_create_payments(element, instance_id, data)
    if element == "quickbooks"
      puts "***** In bulk_create_payments *****"
      data.each do |payment|
        puts "***** Output payment *****"
        puts payment
        puts "***** customerRef *****"
        puts payment[:customerRef]
        puts "***** Skipping create payment *****"
        # customer = QuickbooksCustomer.where(name: payment[:customerRef][:name]).select(:customer_id, :id, :org_id).take
        # next if customer == nil
        # self.create_payment(element, payment, customer)
      end
    else
      # Create another type of entity here
    end
  end
end
