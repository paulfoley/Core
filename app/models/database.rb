class Database
  def self.create_account(element, name, id)

    if element == "sfdc"
      SalesforceAccount.create(name: name, account_id: id).save
    end

  end

  def self.delete_account(element, id)

    if element == "sfdc"

      SalesforceAccount.destroy_all(id)
    end

  end
end
