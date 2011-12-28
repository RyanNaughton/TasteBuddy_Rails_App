require_dependency File.expand_path('../../restaurant', __FILE__)

module Restaurant::Yelp
  def yelp_import
    data = YelpScrape::Client \
      .new(endpoint: yelp_url) \
      .restaurant_data
  end
end
