class CloudElements
  def self.create_instance(element)

    path = "http://api.cloud-elements.com/elements/api-v2/elements/#{element}/oauth/url"
    api_key = '3MVG9uudbyLbNPZM9tgYt1cA4yglnVMRyvCK01x2K8j3Qo1I.MkpK2mm8xTrBdwNPR8BG1HLN4S_5aRnwYPUc'
    api_secret = '3910440158623989535'
    call_back = 'http://127.0.0.1/core/run'
    #redirect  to elements/callback
    url = "#{path}?api_key=#{api_key}&api_secret=#{api_secret}&callbackUrl=#{call_back}&state=#{element}"
    response = Net::HTTP.get(URI.parse(url))

    response_hash = JSON.parse(response)

    # @element = response_hash['element']
    # oauth_url = response_hash['@oauth_url']

    # org_name = org_name
    # user_secret = 'ijHDATuDStgbpAlvXbNTn9gnLIblO5OtiHhbpER3S60='
    # org_secret = '52d24ebf350ceeb29afef2768b668852'
    #
    # path = 'https://console.cloud-elements.com/elements/api-v2/instances'
    # @body = {
    #     :element => {:key => @element},
    #     :providerData => {:code => url_code},
    #     :configuration => {
    #         'oauth.callback.url' => call_back,
    #         'oauth.api.key' => api_key,
    #         'oauth.api.secret' => api_secret},
    #     :name => org_name
    # }.to_json
    #
    # @headers = {
    #     :Authorization => "User => #{user_secret} Organization #{org_secret}",
    #     'Content-Type' => 'application/json'
    # }.to_json
    #
    # request = Net::HTTP::Post.new(path, :body => @body, :headers => @headers)
    #
    # @request_hash = JSON.parse(request)
   end


   #check if customer exists in quickbooks. Used for Stripe integration.
   def self.quickbooksCheckForCustomer(token, customer)

    user_secret = 'ijHDATuDStgbpAlvXbNTn9gnLIblO5OtiHhbpER3S60='

    path = "https://api.cloud-elements.com/elements/api-v2/hubs/finance/customers?where=companyName%3E%3D'#{customer}'"

    @headers = {
        :Authorization => "Element #{token}, User #{user_secret}"
    }.to_json

    request = Net::HTTP::Get.new(path, :headers => @headers)

    #save the response to check if customer exists
    @request_hash = JSON.parse(request)

    #check if customer exists

   end

   def self.quickbooksCreateCustomer(token, customer)

    user_secret = 'ijHDATuDStgbpAlvXbNTn9gnLIblO5OtiHhbpER3S60='

    path = "https://api.cloud-elements.com/elements/api-v2/hubs/finance/customers"

    @body = {
        #:primaryEmailAddr => {
        #    'address' => 
        #},
        :displayName => "#{customer}"
    }

    @headers = {
        :Authorization => "Element #{token}, User #{user_secret}"
    }.to_json

    request = Net::HTTP::Post.new(path, :body => @body, :headers => @headers)

    @request_hash = JSON.parse(request)
    
    end
    
    def self.quickbooksCreatePayment(token, customer)
      
      user_secret = 'ijHDATuDStgbpAlvXbNTn9gnLIblO5OtiHhbpER3S60='

      path = "https://api.cloud-elements.com/elements/api-v2/hubs/finance/payments"

      @body = {

      }

      @headers = {
        :Authorization => "Element #{token}, User #{user_secret}"
      }.to_json

      request = Net::HTTP::Post.new(path, :body => @body, :headers => @headers)


    end

 end