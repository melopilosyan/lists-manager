class ItemsController < ApplicationController
  before_action :authenticate_user!


  # POST /items
  def create
    item = item_params
    list = List.find_by_id item[:list_id]

    list || render_nok && return
    list.not_open? && render_nok("Can't add item to this list. #{LIST_CHANGED_MSG}") && return
    list.items.find_by_user_id(current_user.id) && render_nok('You already added an item to this list') && return

    @item = current_user.items.new item
    @item.save && render('jsons/item') && return

    render_nok @item.errors.full_messages.first
  end

  # PATCH/PUT /lists/1
  def update
    item = current_user.items.find_by_id params[:id]
    item || render_nok && return
    item.list.not_open? && render_nok("Can't update item name. #{LIST_CHANGED_MSG}") && return
    render_nok item.update_name item_update_params[:name]
  end

  # DELETE /items/1
  def destroy
    item = current_user.items.find_by_id params[:id]
    item || render_nok && return
    item.list.not_open? && render_nok("Can't delete item, #{LIST_CHANGED_MSG}") && return
    item.delete
    render_nok false
  end

 private
  def item_update_params
    params.require(:item).permit :name
  end

  def item_params
    params.require(:item).permit :name, :list_id
  end
end
