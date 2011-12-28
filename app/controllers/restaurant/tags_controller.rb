class Restaurant::TagsController < ApplicationController
  # POST /restaurants/1/tag.json
  # PUT /restaurants/1/tag.json
  def create
    @restaurant = Restaurant.find(params[:id])
    @authorized_tag = AuthorizedTag.find_by_name(params[:value])
    @restaurant_tag = Restaurant::Tag.find_or_initialize_by_restaurant_id_and_tag_id_and_user_id(@restaurant.id, @authorized_tag.id, current_user.id)

    respond_to do |format|
      if @restaurant_tag.save
        format.json { render json: @restaurant_tag }
      else
        format.json { render json: @restaurant_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1/tag.json
  def destroy
    @restaurant = Restaurant.find(params[:id])
    @authorized_tag = AuthorizedTag.find_by_name(params[:value])
    @restaurant_tag = Restaurant::Tag.find_by_restaurant_id_and_tag_id_and_user_id(@restaurant.id, @authorized_tag.id, current_user.id)
    @restaurant_tag.present? and @restaurant_tag.destroy

    respond_to do |format|
      format.json { head :ok}
    end
  end
end
