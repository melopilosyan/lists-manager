class MealsController < ApplicationController
  before_action :authenticate_user!


  # POST /meals
  def create
    meal = meal_params
    order = Order.find_by_id meal[:order_id]

    order || render_nok && return
    order.not_ordered? && render_nok("Can't add meal to this order. #{ORDER_CHANGE_MSG}") && return
    order.meals.find_by_user_id(current_user.id) && render_nok('You already added a meal to this order') && return

    @meal = current_user.meals.new meal
    @meal.save && render('jsons/meal') && return

    render_nok @meal.errors.full_messages.first
  end

  # PATCH/PUT /orders/1
  def update
    meal = current_user.meals.find_by_id params[:id]
    meal || render_nok && return
    meal.order.not_ordered? && render_nok("Can't update meal name. #{ORDER_CHANGE_MSG}") && return
    render_nok meal.update_name meal_update_params[:name]
  end

  # DELETE /meals/1
  def destroy
    meal = current_user.meals.find_by_id params[:id]
    meal || render_nok && return
    meal.order.not_ordered? && render_nok("Can't delete meal, #{ORDER_CHANGE_MSG}") && return
    meal.delete
    render_nok false
  end

 private
  def meal_update_params
    params.require(:meal).permit :name
  end

  def meal_params
    params.require(:meal).permit :name, :order_id
  end
end
