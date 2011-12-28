class Restaurant::Menu::Item::TagsController < ApplicationController
  # POST /menu_items/1/tag.json
  # PUT /menu_items/1/tag.json
  def create
    @restaurant_menu_item = Restaurant::Menu::Item.find(params[:id])
    @authorized_tag = AuthorizedTag.find_by_name(params[:value])
    @restaurant_menu_item_tag = Restaurant::Menu::Item::Tag.find_or_initialize_by_restaurant_menu_item_id_and_authorized_tag_id_and_user_id(@restaurant_menu_item.id, @authorized_tag.id, current_user.id)

    respond_to do |format|
      if @restaurant_menu_item_tag.save
        format.json { render json: @restaurant_menu_item_tag }
      else
        format.json { render json: @restaurant_menu_item_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1/tag.json
  def destroy
    @restaurant_menu_item_tag = Restaurant.find(params[:id])
    @authorized_tag = AuthorizedTag.find_by_name(params[:value])
    @restaurant_menu_item_tag = Restaurant::Tag.find_by_restaurant_id_and_authorized_tag_id_and_user_id(@restaurant_menu_item_tag.id, @authorized_tag.id, current_user.id)
    @restaurant_menu_item_tag.present? and @restaurant_menu_item_tag.destroy

    respond_to do |format|
      format.json { head :ok}
    end
  end
end
