class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index

  # GET /orders
  def index
    @orders = Order.includes(:meals, :user).order 'created_at desc'
    render 'jsons/orders'
  end

  # POST /items
  def create
    order = current_user.orders.new(create_order_params)

    if order.save
      meal = params[:order][:meal].strip
      meal.empty? || order.meals.create(name: meal, user_id: current_user.id)
      order.save
      @orders = [order]
      render 'jsons/orders'
    else
      render json: { status: :nok, msg: order.errors }
    end
  end

 private
  def create_order_params
    params.require(:order).permit(:name)
  end
end
