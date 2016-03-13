class CoreController < ApplicationController
  def run
  end

  def create_instance(element)
    require 'net/http'
    require 'json'

    @path = "https://api.cloud-elements.com/elements/api-v2/elements/#{element}/oauth/url"
    @apiKey = '3MVG9uudbyLbNPZM9tgYt1cA4yglnVMRyvCK01x2K8j3Qo1I.MkpK2mm8xTrBdwNPR8BG1HLN4S_5aRnwYPUc'
    @apiSecret = '3910440158623989535'
    @callBack = 'http://127.0.0.1/core/run'
    response = Net::HTTP::Get(URI.parse("#{@path}?apiKey=#{@apiKey}&apiSecret=#{@apiSecret}&callbackUrl=#{@callBack}&state=sfdc"))

    response_hash = JSON.parse(response)

    @element = response_hash['element']
    @oauthUrl = response_hash['oauthUrl']

    @orgName = 'Acme'
    @userSecret = 'ijHDATuDStgbpAlvXbNTn9gnLIblO5OtiHhbpER3S60='
    @orgSecret = '52d24ebf350ceeb29afef2768b668852'

    @path = "https://api.cloud-elements.com/elements/api-v2/instances"
    @body = {
        "element" => {"key" => @element},
        "providerData" => {"code" => "<Code_On_The_Return_URL>"},
        "configuration" => {
        "oauth.callback.url" => "http://127.0.0.1/core/run",
        "oauth.api.key" => @apiKey,
        "oauth.api.secret" => @apiSecret},
        "name" => "#{@orgName} SalesForce"
    }.to_json

    @headers = {
        "Authorization" => {
            "User" => @userSecret,
            "Organization" => @orgSecret
        },

        "Content-Type" => 'application/json'
    }.to_json

    request = Net::HTTP::Post.new(@path, :body => @body, :headers => @headers)

    request_hash = JSON.parse(request)


  end
end
