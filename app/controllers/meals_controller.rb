class MealsController < ApplicationController

  # POST /meals
  def create
    @meal = current_user.meals.new(meal_params)

    if @meal.save
      render 'jsons/meal'
    else
      render json: { status: :nok, msg: meal.errors }
    end
  end

  # PATCH/PUT /orders/1
  def update
    meal = Meal.find params[:id]
    if meal.update params.require(:meal).permit :name
      render json: {status: :ok}
    else
      render json: { status: :nok, msg: meal.errors }
    end
  end

  # DELETE /meals/1
  def destroy
    Meal.find(params[:id]).delete
    head :ok
  end

 private
  def meal_params
    params.require(:meal).permit :name, :order_id
  end
end
