class Restaurant::Menu::Item::CommentsController < ApplicationController
  load_and_authorize_resource(class: 'Restaurant::Menu::Item::Comment')

  # POST /menu_items/1/comment.json
  # PUT /menu_items/1/comment.json
  def create
    @restaurant_menu_item = Restaurant::Menu::Item.find(params[:id])
    @restaurant_menu_item_comment = Restaurant::Menu::Item::Comment.new(restaurant_menu_item_id: @restaurant_menu_item.id, text: params[:text], user_id: current_user.try(:id))

    respond_to do |format|
      if @restaurant_menu_item_comment.save
        format.html { redirect_to "/restaurant_menu_items/#{@restaurant_menu_item.id}", notice: 'Comment was successfully created.' }
        format.json
      else
        format.json { render json: @restaurant_menu_item_comment.errors, status: :unprocessable_entity }
      end
    end
  end
end
