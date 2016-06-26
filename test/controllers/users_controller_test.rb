require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @controller = ApplicationController.new
  end

  test 'user_info should return authenticated:false when no registered users' do
    get :current_user_info
    assert_response :success

    user = JSON.parse(@response.body)
    assert user
    assert_equal user['authenticated'], false
  end

  test 'user_info should return user\'s info' do
    joe = users :joe
    session[:user_id] = joe.id

    get :current_user_info
    assert_response :success

    user = JSON.parse(@response.body)
    assert user
    assert_equal user['name'], joe.name
  end
end