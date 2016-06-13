class OrdersController < ApplicationController

  # GET /orders
  def index
    orders = Order.all
    render json: []
  end
end
