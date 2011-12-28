class User::AttributesController < ApplicationController
  # PUT /users/update.json
  def update
    user = User.find_by_authentication_token(params[:auth_token])

    respond_to do |format|
      if user.update_without_password(params[:user])
        format.json { render json: user, status: :ok }
      else
        format.json { render json: user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /users/profile.json
  def profile
    @pictures_gallery = current_user.pictures_gallery

    respond_to do |format|
      format.json # profile.json.rabl
    end
  end

  # GET /users/bookmarks.json
  def bookmarks
    respond_to do |format|
      format.json
    end
  end
end
