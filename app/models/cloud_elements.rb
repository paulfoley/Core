class CloudElements

  def self.salesforce_oauthurl
    api_key = ENV['SALESFORCE_API_KEY']
    api_secret = ENV['SALESFORCE_API_SECRET']
    callback_url = ENV['INSTANCE_CALLBACK_URL']

    path = "https://staging.cloud-elements.com/elements/api-v2/elements/sfdc/oauth/url"
    url = "#{path}?apiKey=#{api_key}&apiSecret=#{api_secret}&callbackUrl=#{callback_url}&state=sfdc"

#    puts url
    url = URI.parse url
 #   puts url
#    puts url.path + '?' + url.query
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url.path + '?' + url.query)
    response = http.request(request)

    response_parsed = JSON.parse(response.body)
    oauth_url = response_parsed['oauthUrl']
#    puts oauth_url
    return oauth_url

  end


  def self.salesforce_instance(org_name, code)
    user_secret = ENV['CLOUDELEMENTS_USER_SECRET']
    org_secret = ENV['CLOUDELEMENTS_ORG_SECRET']
    api_key = ENV['SALESFORCE_API_KEY']
    api_secret = ENV['SALESFORCE_API_SECRET']
    callback_url = ENV['INSTANCE_CALLBACK_URL']

    headers = {
        'Authorization' => 'User ' + user_secret + ', Organization ' + org_secret,
        'Content-Type' => 'application/json'
    }

    body = {
        'element' => {
        'key' => 'sfdc'
        },
        'providerData' => {
        'code' => code
        },
        'configuration' => {
        'oauth.callback.url' => callback_url,
        'oauth.api.key' => api_key,
        'oauth.api.secret' => api_secret
        },
        'name' => org_name
    }.to_json


    uri = URI('https://staging.cloud-elements.com/elements/api-v2/instances')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    post = Net::HTTP::Post.new(uri.path, headers)
    post.body = body

    response = http.request(post)
    response_parsed = JSON.parse(response.body)

    org = Org.where(name: org_name).select(:name, :salesforce_token, :id).take
    org.update_attributes(:salesforce_token => response_parsed['token'])

    org = Org.where(name: org_name).select(:name, :salesforce_instance_id, :id).take
    org.update_attributes(:salesforce_instance_id => response_parsed['id'])

    self.temp_debug_for_salesforce_polling(response_parsed['token'])
    self.setup_polling(response_parsed['id'], "salesforce")

    if Org.where(name: org_name).select(:quickbooks_token).take.quickbooks_token
      self.create_salesforce_to_quickbooks_formula_instance(org_name)
    end

  end

  #Temporary method until CloudElements fixes the Salesforce event.notification.enabled bug
  def self.temp_debug_for_salesforce_polling(token)
    user_secret = ENV['CLOUDELEMENTS_USER_SECRET']
    org_secret = ENV['CLOUDELEMENTS_ORG_SECRET']

    headers = {
        'Authorization' => 'User ' + user_secret + ', Organization ' + org_secret + ', Element ' + token
    }

    url = URI("https://staging.cloud-elements.com/elements/api-v2/hubs/crm/objects")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url, headers)
    response = http.request(request)

    response_parsed = JSON.parse(response.body)
    puts response_parsed

  end

  def self.salesforce_pull_everything(org_name)
    user_secret = ENV['CLOUDELEMENTS_USER_SECRET']
    token = Org.where(name: org_name).select(:salesforce_token).take.salesforce_token
    instance_id = Org.where(name: org_name).select(:salesforce_instance_id).take.salesforce_instance_id

    headers = {
        'Authorization' => 'Element ' + token + ', User ' + user_secret
    }

    url_accounts = URI("https://staging.cloud-elements.com/elements/api-v2/hubs/crm/accounts")
    http = Net::HTTP.new(url_accounts.host, url_accounts.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url_accounts, headers)
    response = http.request(request)
    puts response.body
    response_parsed_accounts = JSON.parse(response.body)
    Database.bulk_create_accounts("sfdc", instance_id, response_parsed_accounts)

    url_contacts = URI("https://staging.cloud-elements.com/elements/api-v2/hubs/crm/contacts")
    http = Net::HTTP.new(url_contacts.host, url_contacts.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url_contacts, headers)
    response = http.request(request)
    puts response.body
    response_parsed_contacts = JSON.parse(response.body)
    Database.bulk_create_contacts("sfdc", instance_id, response_parsed_contacts)

    url_leads = URI("https://staging.cloud-elements.com/elements/api-v2/hubs/crm/leads")
    http = Net::HTTP.new(url_leads.host, url_leads.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url_leads, headers)
    response = http.request(request)
    puts response.body
    response_parsed_leads = JSON.parse(response.body)
    Database.bulk_create_leads("sfdc", instance_id, response_parsed_leads)

    url_opportunities = URI("https://staging.cloud-elements.com/elements/api-v2/hubs/crm/opportunities")
    http = Net::HTTP.new(url_opportunities.host, url_opportunities.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url_opportunities, headers)
    response = http.request(request)
    puts response.body
    response_parsed_opportunities = JSON.parse(response.body)
    Database.bulk_create_opportunities("sfdc", instance_id, response_parsed_opportunities)

  end


  def self.quickbooks_oauthtoken
    api_key = ENV['QUICKBOOKS_API_KEY']
    api_secret = ENV['QUICKBOOKS_API_SECRET']
    callback_url = ENV['INSTANCE_CALLBACK_URL']

    path = "https://staging.cloud-elements.com/elements/api-v2/elements/quickbooks/oauth/token"
    url = "#{path}?apiKey=#{api_key}&apiSecret=#{api_secret}&callbackUrl=#{callback_url}"

    puts url
    url = URI.parse url
    puts url
    puts url.path + '?' + url.query
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true #(url.scheme == 'https')
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url.path + '?' + url.query)
    response = http.request(request)

    response_parsed = JSON.parse(response.body)
    $quickbooks_request_secret = response_parsed['secret']
    request_token = response_parsed['token']

    oauth_url = self.quickbooks_oauthurl(request_token)
    return oauth_url
  end


  def self.quickbooks_oauthurl(request_token)
    api_key = ENV['QUICKBOOKS_API_KEY']
    api_secret = ENV['QUICKBOOKS_API_SECRET']
    callback_url = ENV['INSTANCE_CALLBACK_URL']

    path = "https://staging.cloud-elements.com/elements/api-v2/elements/quickbooks/oauth/url"
    url = "#{path}?apiKey=#{api_key}&apiSecret=#{api_secret}&callbackUrl=#{callback_url}&requestToken=#{request_token}&state=quickbooks"

    url = URI.parse url
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url.path + '?' + url.query)
    response = http.request(request)

    puts response.body

    response_parsed = JSON.parse(response.body)
    oauth_url = response_parsed['oauthUrl']
    puts oauth_url
    return oauth_url

  end


  def self.quickbooks_instance(org_name, oauth_token, oauth_verifier, realmId, dataSource)

    user_secret = ENV['CLOUDELEMENTS_USER_SECRET']
    org_secret = ENV['CLOUDELEMENTS_ORG_SECRET']
    api_key = ENV['QUICKBOOKS_API_KEY']
    api_secret = ENV['QUICKBOOKS_API_SECRET']
    callback_url = ENV['INSTANCE_CALLBACK_URL']

    headers = {
        'Authorization' => 'User ' + user_secret + ', Organization ' + org_secret,
        'Content-Type' => 'application/json'
    }

    body = {
        'name' => org_name,
        'element' => {
           'key' => 'quickbooks'
        },
        'providerData' => {
           'secret' => $quickbooks_request_secret,
           'oauth_token' => oauth_token,
           'realmId' => realmId,
           'state' => 'quickbooks',
           'dataSource' => dataSource,
           'oauth_verifier' => oauth_verifier
        },
        'configuration' => {
           'oauth.api.key' => api_key,
           'oauth.api.secret' => api_secret,
           'oauth.callback.url' => callback_url
        }
    }.to_json

    uri = URI('https://staging.cloud-elements.com/elements/api-v2/instances')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    post = Net::HTTP::Post.new(uri.path, headers)
    post.body = body

    response = http.request(post)
    response_parsed = JSON.parse(response.body)

    org = Org.where(name: org_name).select(:name, :quickbooks_token, :id).take
    org.update_attributes(:quickbooks_token => response_parsed['token'])

    org = Org.where(name: org_name).select(:name, :quickbooks_instance_id, :id).take
    org.update_attributes(:quickbooks_instance_id => response_parsed['id'])

    self.setup_polling(response_parsed['id'], "quickbooks")

    if Org.where(name: org_name).select(:salesforce_token).take.salesforce_token
      # self.quickbooks_formula_transformation(response_parsed['id'])
      self.create_salesforce_to_quickbooks_formula_instance(org_name)
    end
  end

  def self.quickbooks_pull_everything(org_name)
    user_secret = ENV['CLOUDELEMENTS_USER_SECRET']
    token = Org.where(name: org_name).select(:quickbooks_token).take.quickbooks_token
    instance_id = Org.where(name: org_name).select(:quickbooks_instance_id).take.quickbooks_instance_id

    headers = {
        'Authorization' => 'Element ' + token + ', User ' + user_secret
    }

    url_customers = URI("https://staging.cloud-elements.com/elements/api-v2/hubs/finance/customers")
    http = Net::HTTP.new(url_customers.host, url_customers.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url_customers, headers)
    response = http.request(request)
    puts response.body
    response_parsed_customers = JSON.parse(response.body)
    Database.bulk_create_customers("quickbooks", instance_id, response_parsed_customers)

    url_invoices = URI("https://staging.cloud-elements.com/elements/api-v2/hubs/finance/invoices")
    http = Net::HTTP.new(url_invoices.host, url_invoices.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url_invoices, headers)
    response = http.request(request)
    puts response.body
    response_parsed_invoices = JSON.parse(response.body)
    Database.bulk_create_invoices("quickbooks", instance_id, response_parsed_invoices)

    url_payments = URI("https://staging.cloud-elements.com/elements/api-v2/hubs/finance/payments")
    http = Net::HTTP.new(url_payments.host, url_payments.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url_payments, headers)
    response = http.request(request)
    puts response.body
    response_parsed_payments = JSON.parse(response.body)
    Database.bulk_create_payments("quickbooks", instance_id, response_parsed_payments)

  end


  def self.create_salesforce_to_quickbooks_formula_instance(org_name)

    user_secret = ENV['CLOUDELEMENTS_USER_SECRET']
    org_secret = ENV['CLOUDELEMENTS_ORG_SECRET']
    quickbooks_instance_id = Org.where(name: org_name).select(:quickbooks_instance_id).take.quickbooks_instance_id
    salesforce_instance_id = Org.where(name: org_name).select(:salesforce_instance_id).take.salesforce_instance_id
    formula_id = "1040"

    body = {
        'formula' => {
            'id' => formula_id,
            'active' => 'true',
            'singleThreaded' => 'false'
        },
        'name' => org_name,
        'debugMode' => 'true',
        'active' => 'true',
        'configuration' => {
            'quickbooks.instance' => quickbooks_instance_id,
            'notification.email' => 'developers@corecloudapp.com',
            'salesforce.instance' => salesforce_instance_id
        }
    }.to_json


    headers = {
        'Authorization' => 'User ' + user_secret + ', Organization ' + org_secret,
        'Content-Type' => 'application/json'
    }

    url = URI("https://staging.cloud-elements.com/elements/api-v2/formulas/#{formula_id}/instances")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url, headers)
    request.body = body

    response = http.request(request)
    response_parsed = JSON.parse(response.body)

    puts response_parsed

  end



  def self.setup_polling(instance_id, app)
    user_secret = ENV['CLOUDELEMENTS_USER_SECRET']
    org_secret = ENV['CLOUDELEMENTS_ORG_SECRET']

    headers = {
        'Authorization' => 'User '+ user_secret + ', Organization ' + org_secret
    }

    url = URI("https://staging.cloud-elements.com/elements/api-v2/instances/#{instance_id}/configuration")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url, headers)
    response = http.request(request)

    response_parsed = JSON.parse(response.body)


    event_poller_refresh_interval_id = response_parsed.find {|h| h['key'] == 'event.poller.refresh_interval'}['id']
    puts event_poller_refresh_interval_id

    event_notification_callback_url_id = response_parsed.find {|h| h['key'] == 'event.notification.callback.url'}['id']
    puts event_notification_callback_url_id

    event_vendor_type_id = response_parsed.find {|h| h['key'] == 'event.vendor.type'}['id']
    puts event_vendor_type_id

    event_notification_enabled_id = response_parsed.find {|h| h['key'] == 'event.notification.enabled'}['id']
    puts event_notification_enabled_id

    configuration_headers = {
        'Authorization' => 'User '+ user_secret + ', Organization ' + org_secret,
        'Content-Type' => 'application/json'
    }

    if app == "salesforce"
      event_objects_id = response_parsed.find {|h| h['key'] == 'event.objects'}['id']
      puts event_objects_id

      event_objects_url = URI("https://staging.cloud-elements.com/elements/api-v2/instances/#{instance_id}/configuration/#{event_objects_id}")

      event_vendor_type_body = {
          'name' => 'Objects to Monitor for Changes',
          'key' => 'event.objects',
          'propertyValue' => 'Account, Lead, Opportunity, Contact, Case, CaseComment'
      }.to_json

      http = Net::HTTP.new(event_objects_url.host, event_objects_url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Patch.new(event_objects_url, configuration_headers)
      request.body = event_vendor_type_body
      response = http.request(request)
      response_parsed = JSON.parse(response.body)
      puts response_parsed
    end


    poller_refresh_url = URI("https://staging.cloud-elements.com/elements/api-v2/instances/#{instance_id}/configuration/#{event_poller_refresh_interval_id}")

    poller_refresh_body = {
        'name' => 'Event poller refresh interval',
        'key' => 'event.poller.refresh_interval',
        'propertyValue' => '2'
    }.to_json

    http = Net::HTTP.new(poller_refresh_url.host, poller_refresh_url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Patch.new(poller_refresh_url, configuration_headers)
    request.body = poller_refresh_body
    response = http.request(request)
    response_parsed = JSON.parse(response.body)
    puts response_parsed



    notification_callback_url = URI("https://staging.cloud-elements.com/elements/api-v2/instances/#{instance_id}/configuration/#{event_notification_callback_url_id}")

    notification_callback_body = {
        'name' => 'Event Notification Callback URL',
        'key' => 'event.notifcation.callback.url',
        'propertyValue' => 'http://corecloudapp.herokuapp.com/callback/receive_data'
    }.to_json

    http = Net::HTTP.new(notification_callback_url.host, notification_callback_url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Patch.new(notification_callback_url, configuration_headers)
    request.body = notification_callback_body
    response = http.request(request)
    response_parsed = JSON.parse(response.body)
    puts response_parsed


    event_vendor_type_url = URI("https://staging.cloud-elements.com/elements/api-v2/instances/#{instance_id}/configuration/#{event_vendor_type_id}")

    event_vendor_type_body = {
        'name' => 'Vendor Event Type',
        'key' => 'event.vendor.type',
        'propertyValue' => 'polling'
    }.to_json

    http = Net::HTTP.new(event_vendor_type_url.host, event_vendor_type_url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Patch.new(event_vendor_type_url, configuration_headers)
    request.body = event_vendor_type_body
    response = http.request(request)
    response_parsed = JSON.parse(response.body)
    puts response_parsed


    enable_notification_url = URI("https://staging.cloud-elements.com/elements/api-v2/instances/#{instance_id}/configuration/#{event_notification_enabled_id}")

    enable_notification_body = {
        'name' => 'Enable/Disable Event Notification',
        'key' => 'event.notification.enabled',
        'propertyValue' => 'true'
    }.to_json

    http = Net::HTTP.new(enable_notification_url.host, enable_notification_url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Patch.new(enable_notification_url, configuration_headers)
    request.body = enable_notification_body
    response = http.request(request)

    response_parsed = JSON.parse(response.body)

    puts response_parsed

  end


  def self.stripe_oauth(org_name, code)
    client_secret = ENV['STRIPE_LIVE_SECRET_KEY']

    url = URI('https://connect.stripe.com/oauth/token')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)
    request.set_form_data({'client_secret' => client_secret, 'code' => code, 'grant_type' => 'authorization_code'})

    response = http.request(request)
    response_parsed = JSON.parse(response.body)

    puts response_parsed
    org = Org.where(name: org_name).select(:name, :stripe_token, :id).take
    org.update_attributes(:stripe_token => response_parsed['stripe_user_id'])

  end



   #check if customer exists in quickbooks. Used for Stripe integration.
   def self.quickbooks_payment(stripe_token, customer_name, amount_paid)

     user_secret = ENV['CLOUDELEMENTS_USER_SECRET']

     token = Org.where(stripe_token: stripe_token).select(:quickbooks_token).take.quickbooks_token

     headers = {
         'Authorization' => 'Element '+ token + ', User ' + user_secret
     }

     encoded_customer = URI::encode(customer_name)

     path = "https://staging.cloud-elements.com/elements/api-v2/hubs/finance/customers"
     url = "#{path}?where=displayName%3E%3D%27#{encoded_customer}%27"

     url = URI.parse url

     http = Net::HTTP.new(url.host, url.port)
     http.use_ssl = true
     http.verify_mode = OpenSSL::SSL::VERIFY_NONE
     request = Net::HTTP::Get.new(url.path + '?' + url.query, headers)


     #save the response to check if customer exists
     response = http.request(request)

     response_parsed = JSON.parse(response.body)

     if response_parsed[0]['companyName'] == customer_name
       # puts "TRUE"
       self.quickbooks_add_payment_to_customer(token, response_parsed[0]['id'], customer_name, amount_paid)
     else
       # puts "FALSE"
       self.quickbooks_create_customer_and_payment(token, customer_name, amount_paid)
     end
   end



   def self.quickbooks_create_customer_and_payment(token, customer_name, amount_paid)

    user_secret = ENV['CLOUDELEMENTS_USER_SECRET']

    body = {
        'displayName' => customer_name,
        'companyName' => customer_name,
    }.to_json

    headers = {
        'Authorization' => 'Element ' + token + ', User ' + user_secret,
        'Content-Type' => 'application/json'
    }


    url = URI("https://staging.cloud-elements.com/elements/api-v2/hubs/finance/customers")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(url, headers)
    request.body = body
    response = http.request(request)

    response_parsed = JSON.parse(response.body)

    # puts response_parsed
    # puts response_parsed['id']




    payment_body = {
        'customerRef' => {
            'name' => customer_name,
            'value' => response_parsed['id']
        },
        'depositToAccountRef' => {
            'value' => '4'
        },
        'paymentMethodRef' => {
            'value' => '3'
        },
        'totalAmt' => amount_paid
    }.to_json

    payment_url = URI("https://staging.cloud-elements.com/elements/api-v2/hubs/finance/payments")

    http = Net::HTTP.new(payment_url.host, payment_url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(payment_url, headers)
    request.body = payment_body
    response = http.request(request)

    # response_parsed = JSON.parse(response.body)
    #
    # puts response_parsed
    
    end
    
    def self.quickbooks_add_payment_to_customer(token, customer_id, customer_name, amount_paid)
      
      user_secret = ENV['CLOUDELEMENTS_USER_SECRET']

      body = {
          'customerRef' => {
          'name' => customer_name,
          'value' => customer_id
      },
          'depositToAccountRef' => {
          'value' => '4'
      },
          'paymentMethodRef' => {
          'value' => '3'
      },
          'totalAmt' => amount_paid
      }.to_json

      headers = {
          'Authorization' => 'Element ' + token + ', User ' + user_secret,
          'Content-Type' => 'application/json'
      }

      url = URI("https://staging.cloud-elements.com/elements/api-v2/hubs/finance/payments")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Post.new(url, headers)
      request.body = body
      response = http.request(request)

      # response_parsed = JSON.parse(response.body)
      #
      # puts response_parsed


    end

 end