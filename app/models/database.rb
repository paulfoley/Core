class Database

  def self.create_org(name)
    if User.where(name: name).select(:name).take == nil
      Org.create(:name => name)
    end
  end

  def self.create_user(name, email, password, is_admin, org)

    if User.where(email: email).select(:email).take == nil
      User.create(:name => name, :email => email, :password => password, :is_admin => is_admin, :org => org)
    end

  end

  def self.create_account(element, id, name)

    if element == "sfdc"
      SalesforceAccount.create(name: name, account_id: id)
    elsif element == "quickbooks"
      QuickbooksAccount.create(name: name, account_id: id)
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
