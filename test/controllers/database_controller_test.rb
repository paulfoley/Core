require 'test_helper'

class DatabaseControllerTest < ActionController::TestCase
  test "should get add_salesforce_account" do
    get :add_salesforce_account
    assert_response :success
  end

end
