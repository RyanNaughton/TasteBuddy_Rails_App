class Restaurant::CommentsController < ApplicationController
  load_and_authorize_resource(class: 'Restaurant::Comment')

  # POST /restaurants/1/comment.json
  # PUT /restaurants/1/comment.json
  def create
    @restaurant = Restaurant.find(params[:id])
    @restaurant_comment = Restaurant::Comment.new(restaurant_id: @restaurant.id, text: params[:text], user_id: current_user.id)

    respond_to do |format|
      if @restaurant_comment.save
        format.json
      else
        format.json { render json: @restaurant_comment.errors, status: :unprocessable_entity }
      end
    end
  end
end
