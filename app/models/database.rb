class Database
  def self.create_salesforce_account(name)
      SalesforceAccount.create(name: name).save
  end
end
