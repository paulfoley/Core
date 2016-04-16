class Database
  def self.create_account(element, id, name)

    if element == "sfdc"
      SalesforceAccount.create(name: name, account_id: id).save
    end

  end

  def self.delete_account(element, id)

    if element == "sfdc"
      SalesforceAccount.where(account_id: id).delete_all
    end

  end

  def self.update_account(element, id, name)

    if element == "sfdc"
      SalesforceAccount.where(:account_id => id).update_all(name: name)

    end

  end
end
