class Restaurant::Menu::Item::RatingsController < ApplicationController
  # POST /menu_items/1/rate.json
  # PUT /menu_items/1/rate.json
  def create
    puts "current user id is #{current_user.id}"
    @restaurant_menu_item = Restaurant::Menu::Item.find(params[:id])
    puts "value is #{params[:value]}"
    params[:value] =     params[:value].to_i
    @restaurant_menu_item.present? and puts "menu item present"
    @restaurant_menu_item.id.present? and puts "menu item id"

    @restaurant_menu_item_rating = ::Restaurant::Menu::Item::Rating.find_or_initialize_by_restaurant_menu_item_id_and_user_id(@restaurant_menu_item.id, current_user.id)
    @restaurant_menu_item_rating.persisted? ? puts("rating persisted") : puts("new rating")
    puts "WARN NIL o " if @restaurant_menu_item_rating.nil?
    @restaurant_menu_item_rating.value = params[:value]

    respond_to do |format|
      if @restaurant_menu_item_rating.save and @restaurant_menu_item.reload
        format.json # create.json.rabl
        format.html { redirect_to "/restaurant_menu_items/#{@restaurant_menu_item.id}", notice: 'Rating was successfully updated.' }
      else
        format.json { render json: @restaurant_menu_item_rating.errors, status: :unprocessable_entity }
      end
    end
  end
end
