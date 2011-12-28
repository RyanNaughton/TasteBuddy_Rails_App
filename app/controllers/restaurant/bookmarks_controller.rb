class Restaurant::BookmarksController < ApplicationController
  # POST /restaurants/1/bookmark.json
  # PUT /restaurants/1/bookmark.json
  def create
    @restaurant = Restaurant.find(params[:id])
    @bookmark = ::Restaurant::Bookmark.find_or_initialize_by_restaurant_id_and_user_id(
      restaurant_id: @restaurant.id, user_id: current_user.id
    )

    respond_to do |format|
      if @bookmark.persisted? or @bookmark.save
        format.json { render json: {:status => :success} } # monkey legacy: { head :ok }
      else
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1/bookmark.json
  def destroy
    @bookmark = ::Restaurant::Bookmark.find_by_restaurant_id_and_user_id(params[:id], current_user.id)
    @bookmark.present? and @bookmark.destroy

    respond_to do |format|
      format.json { render json: {:status => :success} } # monkey legacy: { head :ok }
    end
  end
end
