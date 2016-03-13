class CoreController < ApplicationController
  def run
  end

  def instance_salesforce
    require 'net/http'
    require 'json'

    @path = 'https://api.cloud-elements.com/elements/api-v2/elements/sfdc/oauth/url'
    @apiKey = '3MVG9uudbyLbNPZM9tgYt1cA4yglnVMRyvCK01x2K8j3Qo1I.MkpK2mm8xTrBdwNPR8BG1HLN4S_5aRnwYPUc'
    @apiSecret = '3910440158623989535'
    @callBack = 'https://www.demonstrab.ly/home'
    response = Net::HTTP::Get(URI.parse("#{@path}?apiKey=#{@apiKey}&apiSecret=#{@apiSecret}&callbackUrl=#{@callBack}&state=sfdc"))

    response_hash = JSON.parse(response)

    @element = response_hash[element]
    @oauthUrl = response_hash[oauthUrl]



  end
end
