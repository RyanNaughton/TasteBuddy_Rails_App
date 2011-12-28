class Restaurant::RatingsController < ApplicationController
  # POST /restaurants/1/rate.json
  # PUT /restaurants/1/rate.json
  def create
    @restaurant = Restaurant.find(params[:id])
    @restaurant_rating = ::Restaurant::Rating.find_or_initialize_by_restaurant_id_and_user_id(@restaurant.id, current_user.id)
    @restaurant_rating.value = params[:value]

    respond_to do |format|
      if @restaurant_rating.save and @restaurant.reload
        format.json # create.json.rabl
      else
        format.json { render json: @restaurant_rating.errors, status: :unprocessable_entity }
      end
    end
  end
end
