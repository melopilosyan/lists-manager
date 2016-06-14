class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index

  # GET /orders
  def index
    @orders = Order.includes(:meals, :user).order 'created_at desc'
    render 'jsons/orders'
  end

  # POST /orders
  def create
    order = current_user.orders.new(order_params)

    if order.save
      meal = params[:order][:meal].strip
      meal.empty? || order.meals.create(name: meal, user_id: current_user.id)
      @orders = [order]
      render 'jsons/orders'
    else
      render json: { status: :nok, msg: order.errors }
    end
  end

  # PATCH/PUT /orders/1
  def update
    json = {status: :nok, msg: 'Wrong params'}
    if params.key? :order
      if params[:order].key? :name
        key = :name
      elsif params[:order].key? :status
        key = :status
      end
      order = Order.find(params[:id])
      order.update_attribute(key, Order::Status.from_string(params[:order][key])) ?
        json[:status] = :ok : json[:msg] = order.errors
    end
    render json: json
  end

  # DELETE /orders/1
  def destroy
    Order.find(params[:id]).delete
    head :ok
  end

 private
  def order_params
    params.require(:order).permit(:name)
  end
end
