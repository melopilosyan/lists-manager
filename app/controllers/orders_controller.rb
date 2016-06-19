class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index

  # GET /orders
  def index
    @orders = case params[:type]
                when 'active'
                  Order.active
                when'archived'
                  Order.archived
                else
                []
              end
    render 'jsons/orders'
  end

  # POST /orders
  def create
    order = current_user.orders.new(order_params)
    order.save || render_nok(order.errors.full_massages.first) && return

    meal = params[:order].fetch :meal, ''
    meal.empty? || order.meals.create(name: meal, user_id: current_user.id) && return
    @orders = [order]
    render 'jsons/orders'
  end

  # PATCH/PUT /orders/1
  def update
    order = current_user.orders.find_by_id params[:id]
    order || render_nok && return
    render_nok order.update_with params[:order], "Can't update name. #{ORDER_CHANGE_MSG}"
  end

  # DELETE /orders/1
  def destroy
    current_user.orders.find_by_id(params[:id]).delete rescue 1
    render_nok false
  end

 private
  def order_params
    params.require(:order).permit(:name)
  end
end

