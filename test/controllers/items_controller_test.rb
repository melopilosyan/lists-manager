require 'test_helper'

class ItemsControllerTest < ActionController::TestCase

  test 'should add item to the list created by others' do
    joe = users :joe
    list = lists :list
    item_id = 0

    session[:user_id] = joe.id

    assert_difference('Item.count', 1, 'Should add item to others lists') do
      post :create, item: { name: 'item 2', list_id: list.id }
      item_id = (JSON.parse(@response.body)['item']['id'] rescue 0)
    end

    post :create, item: { name: 'item 3', list_id: list.id }
    assert_equal JSON.parse(@response.body)['status'], 'nok', 'should add just one item'

    assert_difference('Item.count', -1, 'Should delete item added to others list') do
      delete :destroy, id: item_id
    end
  end
end
