require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @joe = users :joe

    @order2 = 'order 2'
    @order1 = 'order 1'

    @meal1 = 'pizza'
    @meal2 = 'cake'
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test 'should not create/update/delete order for a non logged in user' do
    msg = 'Please login'

    post :create
    assert_equal msg, JSON.parse(@response.body)['msg'], 'create'
    
    patch :update, id: 1
    assert_equal msg, JSON.parse(@response.body)['msg'], 'update'
    
    delete :destroy, id: 1
    assert_equal msg, JSON.parse(@response.body)['msg'], 'delete'
    
  end

  test 'should create/update/delete order for a logged in user and add/update meal' do
    Order.delete_all
    Meal.delete_all
    order_id = meal_id = 0

    session[:user_id] = @joe.id

    assert_difference('Order.count', 1, 'Order\'s create should create new order') do
      post :create, order: { name: @order1 }

      response = JSON.parse @response.body
      assert !response['orders'].nil?, 'Order\'s create should return order\'s JSON'
      assert_equal @order1, (response['orders'][0]['name'] rescue ''),
        'Order\'s create should return created order'
      assert_equal @joe.name, (response['orders'][0]['creator']['name'] rescue ''),
        'Order\'s create should create new order for logged in user'
      order_id = (response['orders'][0]['id'] rescue order_id)

      # Update name
      patch :update, id: order_id, order: {name: @order2}

      assert_equal @order2, (Order.find_by(id: order_id).name rescue @order1),
        'Orders update name should update order\'s name'

      # Update Status
      patch :update, id: order_id, order: {status: 'Delivered'}

      assert_response :success, 'Order\'s update status should succeed'
      assert_equal Order::Status::DELIVERED, (Order.find_by(id: order_id).status rescue Order::Status::ORDERED),
        'Order\'s update status should update order\'s status'

    end

    @controller = MealsController.new

    # Add/update meal
    assert_difference('Meal.count', 1, 'Meal\'s create should create new meal') do
      post :create, meal: { name: @meal1, order_id: order_id }

      assert_response :success, 'Meals create should succeed'

      response = JSON.parse @response.body
      assert !response['meal'].nil?, 'Meal\'s create should return meal\'s JSON'
      assert_equal @meal1, (response['meal']['name'] rescue ''), 'Meal\'s create should return created meal'
      assert_equal @joe.name, (response['meal']['creator']['name'] rescue ''),
        'Meal create should create meal for logged in user'
      meal_id = (response['meal']['id'] rescue meal_id)

      # Update name
      patch :update, id: meal_id, meal: {name: @meal2}

      assert_response :success, 'Meal\'s update name should succeed'
      assert_equal @meal2, (Meal.find_by(id: meal_id).name rescue @meal1),
        'Meal\'s update name should update meal\'s name'

      post :create, meal: { name: @meal2, order_id: order_id }
    end

    post :create, meal: { name: @meal1, order_id: order_id }
    response = JSON.parse @response.body
    assert_equal response['status'], 'nok', 'Should not create to meals for a user under the same order'

    assert_difference('Meal.count', -1, 'Meals\'s delete should delete the meal') do
      delete :destroy, id: meal_id
    end

    @controller = OrdersController.new
    assert_difference('Order.count', -1, 'Order\'s delete should delete the order') do
      delete :destroy, id: order_id
    end
  end
end

