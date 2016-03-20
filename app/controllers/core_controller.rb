class CoreController < ApplicationController
  def run
  end

  def apps
    render json: {
        CRM: {
            appName: "Salesforce",
            appIcon: "http://s1.q4cdn.com/454432842/files/design/newlogo-company.png",
            oauthURL: "https://login.salesforce.com/services/oauth2/authorize?response_type=code&client_id=3MVG9uudbyLbNPZM9tgYt1cA4yglnVMRyvCK01x2K8j3Qo1I.MkpK2mm8xTrBdwNPR8BG1HLN4S_5aRnwYPUc&client_secret=3910440158623989535&scope=full%20refresh_token&redirect_uri=https://bwgaydon.github.io/core/index.html&state=sfdc"
        },
    }
  end




end
