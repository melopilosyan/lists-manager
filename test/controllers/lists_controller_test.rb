require 'test_helper'

class ListsControllerTest < ActionController::TestCase
  setup do
    @joe = users :joe

    @list2 = 'list 2'
    @list1 = 'list 1'

    @item1 = 'pizza'
    @item2 = 'cake'
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:lists)
  end

  test 'should not create/update/delete list for a non logged in user' do
    msg = 'Please login'

    post :create
    assert_equal msg, JSON.parse(@response.body)['msg'], 'create'
    
    patch :update, id: 1
    assert_equal msg, JSON.parse(@response.body)['msg'], 'update'
    
    delete :destroy, id: 1
    assert_equal msg, JSON.parse(@response.body)['msg'], 'delete'
    
  end

  test 'should create/update/delete list for a logged in user and add/update item' do
    List.delete_all
    Item.delete_all
    list_id = item_id = 0
    open, finalized = List::State::OPEN, List::State::FINALIZED

    session[:user_id] = @joe.id

    assert_difference('List.count', 1, 'List\'s create should create new list') do
      post :create, list: { name: @list1 }

      response = JSON.parse @response.body
      assert !response['lists'].nil?, 'List\'s create should return list\'s JSON'
      assert_equal @list1, (response['lists'][0]['name'] rescue ''),
        'List\'s create should return created list'
      assert_equal @joe.name, (response['lists'][0]['creator']['name'] rescue ''),
        'List\'s create should create new list for logged in user'
      list_id = (response['lists'][0]['id'] rescue list_id)

      # Update name
      patch :update, id: list_id, list: {name: @list2}

      assert_equal @list2, (List.find_by(id: list_id).name rescue @list1),
        'Lists update name should update list\'s name'

      # Update state
      patch :update, id: list_id, list: {state: finalized}

      assert_response :success, 'List\'s update state should succeed'
      assert_equal finalized, (List.find_by(id: list_id).state rescue open),
        'List\'s update state should update list\'s state'

    end

    @controller = ItemsController.new
    post :create, item: { name: @item1, list_id: list_id }
    assert_equal JSON.parse(@response.body)['status'], 'nok', 'Should not add item to not open list'

    @controller = ListsController.new
    patch :update, id: list_id, list: {state: open}
    assert_equal open, (List.find_by(id: list_id).state rescue finalized),
      'List\'s update state should update list\'s state(second try)'

    # Add/update item
    @controller = ItemsController.new
    assert_difference('Item.count', 1, 'Item\'s create should create new item') do
      post :create, item: { name: @item1, list_id: list_id }

      response = JSON.parse @response.body

      assert !response['item'].nil?, 'Item\'s create should return item\'s JSON'
      assert_equal @item1, (response['item']['name'] rescue ''),
        'Item\'s create should return created item'
      assert_equal @joe.name, (response['item']['creator']['name'] rescue ''),
        'Item create should create item for logged in user'
      item_id = (response['item']['id'] rescue item_id)

      # Update name
      patch :update, id: item_id, item: {name: @item2}

      assert_equal @item2, (Item.find_by(id: item_id).name rescue @item1),
        'Item\'s update name should update item\'s name'
    end

    post :create, item: { name: @item1, list_id: list_id }
    assert_equal JSON.parse(@response.body)['status'], 'nok',
       'Should not create two items for a user under the same list'

    assert_difference('Item.count', -1, 'Items\'s delete should delete the item') do
      delete :destroy, id: item_id
    end

    @controller = ListsController.new
    assert_difference('List.count', -1, 'List\'s delete should delete the list') do
      delete :destroy, id: list_id
    end
  end
end

