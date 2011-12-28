class EugeneCachesController < ApplicationController
  # GET /eugene_caches.json
  def index
    attrs = {find: '', near: '', festival_id: 1, coordinates: [41.875792, -87.618944], user_id: 1}
    search = Search.new(attrs)
    @results = search.results

    respond_to do |format|
      format.json # index.json.rabl
    end
  end

  # POST /eugene_caches.json
  def create
    @cache = CachedRecord.find_or_initialize_by_festival_id(params[:festival_id])
    @cache.json = params[:json].to_json

    respond_to do |format|
      if @cache.save
        format.json { head :ok }
      else
        format.json { render json: @cache.errors, status: :unprocessable_entity }
      end
    end
  end
end
