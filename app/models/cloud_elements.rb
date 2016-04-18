class CloudElements

  def self.salesforce_oauthurl
    api_key = ENV['SALESFORCE_API_KEY']
    api_secret = ENV['SALESFORCE_API_SECRET']
    callback_url = ENV['INSTANCE_CALLBACK_URL']

    path = "https://api.cloud-elements.com/elements/api-v2/elements/sfdc/oauth/url"
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


    uri = URI('https://api.cloud-elements.com/elements/api-v2/instances')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    post = Net::HTTP::Post.new(uri.path, headers)
    post.body = body

    response = http.request(post)

    puts response.body
    puts response.code

  end


  def self.quickbooks_oauthtoken
    api_key = ENV['QUICKBOOKS_API_KEY']
    api_secret = ENV['QUICKBOOKS_API_SECRET']
    callback_url = ENV['INSTANCE_CALLBACK_URL']

    path = "https://api.cloud-elements.com/elements/api-v2/elements/quickbooks/oauth/token"
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


  def self.quickbooks_oauthurl(token)
    api_key = ENV['QUICKBOOKS_API_KEY']
    api_secret = ENV['QUICKBOOKS_API_SECRET']
    callback_url = ENV['INSTANCE_CALLBACK_URL']

    path = "https://api.cloud-elements.com/elements/api-v2/elements/quickbooks/oauth/url"
    url = "#{path}?apiKey=#{api_key}&apiSecret=#{api_secret}&callbackUrl=#{callback_url}&requestToken=#{token}&state=quickbooks"

    puts url
    url = URI.parse url
    puts url
    puts url.path + '?' + url.query
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true #(url.scheme == 'https')
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


    uri = URI('https://api.cloud-elements.com/elements/api-v2/instances')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    post = Net::HTTP::Post.new(uri.path, headers)
    post.body = body

    response = http.request(post)

    puts response.body
    puts response.code

  end



  def self.setup_polling

  end


   #check if customer exists in quickbooks. Used for Stripe integration.
   def self.quickbooksCheckForCustomer(customer)

     user_secret = ENV['CLOUDELEMENTS_USER_SECRET']
     token = "KIx65kljd0EL3O0DlwGAMCDjR6drDbwIl3sSSHtkyq4="

#    token = Org.where(:name => name).select(salesforce_token).take

     headers = {
         'Authorization' => 'Element '+ token + ', User ' + user_secret
     }

     encoded_customer = URI::encode(customer)

     path = "https://api.cloud-elements.com/elements/api-v2/hubs/finance/customers"
     url = "#{path}?where=displayName%3E%3D%27#{encoded_customer}%27"

     url = URI.parse url

     http = Net::HTTP.new(url.host, url.port)
     http.use_ssl = true
     http.verify_mode = OpenSSL::SSL::VERIFY_NONE
     request = Net::HTTP::Get.new(url.path + '?' + url.query, headers)


     #save the response to check if customer exists
     response = http.request(request)

     response_parsed = JSON.parse(response.body)


     if response_parsed[0]['companyName'] == customer
       puts "TRUE"
     else
       puts "FALSE"
     end
   end

   def self.quickbooksCreateCustomer(customer)

    user_secret = 'ijHDATuDStgbpAlvXbNTn9gnLIblO5OtiHhbpER3S60='

    path = "https://api.cloud-elements.com/elements/api-v2/hubs/finance/customers"

    body = {
        #:primaryEmailAddr => {
        #    'address' => 
        #},
        :displayName => "#{customer}"
    }

    headers = {
        :Authorization => "Element #{token}, User #{user_secret}"
    }.to_json

    request = Net::HTTP::Post.new(path, :body => body, :headers => headers)

    request_hash = JSON.parse(request)
    
    end
    
    def self.quickbooksCreatePayment(token, customer)
      
      user_secret = 'ijHDATuDStgbpAlvXbNTn9gnLIblO5OtiHhbpER3S60='

      path = "https://api.cloud-elements.com/elements/api-v2/hubs/finance/payments"

      body = {

      }

      headers = {
        :Authorization => "Element #{token}, User #{user_secret}"
      }.to_json

      request = Net::HTTP::Post.new(path, :body => body, :headers => headers)


    end

 end