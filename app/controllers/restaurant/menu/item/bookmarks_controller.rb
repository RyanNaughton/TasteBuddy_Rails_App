class Restaurant::Menu::Item::BookmarksController < ApplicationController
  # POST /menu_items/1/bookmark.json
  # PUT /menu_items/1/bookmark.json
  def create
    @restaurant_menu_item = Restaurant::Menu::Item.find(params[:id])
    @bookmark = Restaurant::Menu::Item::Bookmark.find_or_initialize_by_restaurant_menu_item_id_and_user_id(
      restaurant_menu_item_id: @restaurant_menu_item.id, user_id: current_user.id
    )

    respond_to do |format|
      if @bookmark.persisted? or @bookmark.save
        format.json { render json: {:status => :success} } # monkey legacy: { head :ok }
      else
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menu_items/1/bookmark.json
  def destroy
    @bookmark = ::Restaurant::Menu::Item::Bookmark.find_by_restaurant_menu_item_id_and_user_id(params[:id], current_user.id)
    @bookmark.present? and @bookmark.destroy

    respond_to do |format|
      format.json { render json: {:status => :success} } # monkey legacy: { head :ok }
    end
  end
end
