class Database
  def self.create_account(element, name)

    if element == "sfdc"
      SalesforceAccount.create(name: name).save
    end

  end

  def self.delete_account(element, name)

    if element == "sfdc"

      # Delete SalesforceAccount here.
    end

  end
end
