class AuthorizedTagsController < ApplicationController
  # GET /tags.json
  def tag_names
    @authorized_tags = AuthorizedTag.all

    respond_to do |format|
      format.json { render json: @authorized_tags.map(&:name) }
    end
  end
end
