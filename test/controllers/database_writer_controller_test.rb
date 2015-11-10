require 'test_helper'

class DatabaseWriterControllerTest < ActionController::TestCase
  test "should get Write" do
    get :Write
    assert_response :success
  end

  test "should get to" do
    get :to
    assert_response :success
  end

  test "should get db" do
    get :db
    assert_response :success
  end

end
