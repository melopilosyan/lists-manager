require 'test_helper'

class MealsControllerTest < ActionController::TestCase

  test 'should add meal to the order created by others' do
    joe = users :joe
    order = orders :order
    meal_id = 0

    session[:user_id] = joe.id

    assert_difference('Meal.count', 1, 'Should add meal to others orders') do
      post :create, meal: { name: 'meal 2', order_id: order.id }
      meal_id = (JSON.parse(@response.body)['meal']['id'] rescue 0)
    end

    post :create, meal: { name: 'meal 3', order_id: order.id }
    assert_equal JSON.parse(@response.body)['status'], 'nok', 'should add just one meal'

    assert_difference('Meal.count', -1, 'Should delete meal added to others order') do
      delete :destroy, id: meal_id
    end
  end
end
