class ListsController < ApplicationController
  before_action :authenticate_user!, except: :index

  # GET /lists
  def index
    @lists = case params[:type]
                when 'active'
                  List.active
                when'archived'
                  List.archived
                else
                []
              end
    render 'jsons/lists'
  end

  # POST /lists
  def create
    list = current_user.lists.new(list_params)
    list.save || render_nok(list.errors.full_massages.first) && return

    item = params[:list].fetch :item, ''
    item.empty? || list.items.create(name: item, user_id: current_user.id)
    @lists = [list]
    render 'jsons/lists'
  end

  # PATCH/PUT /lists/1
  def update
    list = current_user.lists.find_by_id params[:id]
    list || render_nok && return
    render_nok list.update_with params[:list], "Can't update name. #{LIST_CHANGED_MSG}"
  end

  # DELETE /lists/1
  def destroy
    current_user.lists.find_by_id(params[:id]).delete rescue 1
    render_nok false
  end

 private
  def list_params
    params.require(:list).permit(:name)
  end
end

