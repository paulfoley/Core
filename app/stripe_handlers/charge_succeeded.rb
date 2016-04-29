class ChargeSucceeded < ApplicationController

  def self.webhook(event)
    # stripe handler for charge.succeeded event
    stripe_token = event[:user_id]
    puts stripe_token

    # reassign stripe api key to fit test secret key of account matching stripe_token
    #stripe_key = StripeCustomer.where(stripe_user_id: stripe_token).select(:stripe_test_secret_key).take.stripe_test_secret_key
    #Stripe.api_key = stripe_key

    # pull customer from database
    # use email to match with the customer generated when sale made in SF -> invoice in QB
    customer_id = event[:data][:object][:customer]
    customer = Stripe::Customer.retrieve(customer_id.to_s)
    #puts customer
    stripe_email = customer.email
    #puts stripe_email
    # use email to get SF contact
    # then use sf_account_id to get the company name from the SF account
    org_id_s = Org.where(stripe_token: stripe_token).take.org_id
    sf_contact_to_account = SalesforceContact.where(email: stripe_email) and where(org_id: org_id_s).select(:salesforce_account_id).take.salesforce_account_id
    customer_name = SalesforceAccount.where(account_id: sf_contact_to_account).select(:name).take.name
    puts customer_name


    amount_paid = event[:data][:object][:amount] * 0.01
    puts amount_paid

    # call quickbooks_payment to automate data transfer of payment from Stripe to QB
    CloudElements.quickbooks_payment(stripe_token, customer_name, amount_paid)

  end
end