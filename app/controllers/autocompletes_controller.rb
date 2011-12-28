class AutocompletesController < ApplicationController
  # GET /complete.html
  def new
    fail NotImplementedError
    @search = Search.new

    respond_to do |format|
      format.html # index.html.haml
    end
  end

  # POST /complete
  # POST /complete.json
  def show
    attrs = params[:autocomplete].merge(user: current_user)
    attrs[:near].to_s.include?('Current Location') and attrs[:near] = %q{}
    %w{action controller show}.each {|attr_name| attrs.delete(attr_name) }

    @search = Search.new(attrs)
    @results = @search.autocomplete

    respond_to do |format|
      format.json { render json: @results }
    end
  end
end
