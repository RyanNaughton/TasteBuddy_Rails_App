class SearchController < ApplicationController

  # GET /search.html
  def new
    @search = Search.new

    respond_to do |format|
      format.html # index.html.haml
    end
  end

  # POST /search
  # POST /search.json
  def show
    @search = Search.new(params[:search].merge(user_id: current_user.try(:id)))
    @search.near.to_s.include?('Current Location') and @search.near = ''
    @search.save!

    if @search.festival_id and @search.find.blank?
      @cached_record = CachedRecord.find_by_festival_id(@search.festival_id)
    end

    if @cached_record.blank? or @cached_record.updated_at < 1.day.ago
      @results = @search.results
    end

    respond_to do |format|
      if @cached_record.present?
        if @search.coordinates.present?
          results = JSON.parse(@cached_record.json).each do |result|
            result['distance'] = distance_to(result['location'], @search.coordinates)
          end
          .sort_by {|result| result['distance']}
          format.json { render json: results }
        else
          format.json { render text: @cached_record.json, content_type: 'application/json' }          
        end
      else
        format.json # index.json.rabl
      end
    end
  end

  def distance_to(loc_coords, user_coords)
    latitude, longitude = loc_coords.map(&:to_f)
    Haversine
      .distance(latitude.to_f, longitude.to_f, *user_coords.map(&:to_f))[:miles]
      .number
      .round(2)
  end
end
