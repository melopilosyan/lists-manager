class MealsController < ApplicationController

  # POST /meals
  def create
    meal = current_user.meals.new(meal_params)

    if meal.save
      @orders = [meal.order]
      render 'jsons/orders'
    else
      render json: { status: :nok, msg: meal.errors }
    end
  end

 private
  def meal_params
    params.require(:meal).permit(:name, :order_id)
  end
end
