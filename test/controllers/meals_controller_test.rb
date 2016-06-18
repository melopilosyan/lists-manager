require 'test_helper'

class MealsControllerTest < ActionController::TestCase

  test 'should add meal to the order created by others' do
    joe = users :joe
    order = orders :order
    session[:user_id] = joe.id

    assert_difference('Meal.count') do
      post :create, meal: { name: 'meal 2', order_id: order.id }
    end

    post :create, meal: { name: 'meal 3', order_id: order.id }
    assert_equal JSON.parse(@response.body)['msg'], 'Already added a meal to this order', 'should add just one meal'
  end
end
