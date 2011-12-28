require_dependency File.expand_path('../../restaurant', __FILE__)

module Restaurant::Instagram
  def ensure_instagram_v1
    foursquare_v1.present? or raise ArgumentError, 'foursquare_v1 required'
    instagram_v1.present? and return instagram_v1
    self.instagram_v1 ||=
      begin
        InstaScrape::Client.new.location_id_by_foursquare_id(foursquare_v1)
      rescue NoMethodError
        nil # Instagram ID mapping missing for ~30% of prominent Foursquare locations
      end
  end
end
