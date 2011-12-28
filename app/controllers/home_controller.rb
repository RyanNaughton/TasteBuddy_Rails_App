class HomeController < ApplicationController
  # GET /
  def index
    respond_to do |format|
      format.html # index.html.haml
    end
  end
end
