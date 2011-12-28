class Search < ActiveRecord::Base
  include Geokit::Geocoders
  belongs_to :user

  serialize :coordinates, Array

  CHICAGO_COORDINATES = [41.881944, -87.627778].freeze # [41.8, -87.59] is Hyde Park
  CUISINE_TYPES = Restaurant
                    .connection
                    .select_values('SELECT DISTINCT cuisine_type FROM restaurants ORDER BY cuisine_type ASC')
                    .compact
                    .map(&:downcase)
                    .freeze

  def after_initialize
    if coordinates.all? {|c| c.to_f.nonzero? }
      self.latitude, self.longitude = coordinates.map(&:to_f)
    end
  end

  def results(options={})
    options = options.merge(festival_id: festival_id)
    Restaurant.search(find, location, options)
  end

  def location
    @coords ||= if near.present?
      lookup_coordinates
    elsif coordinates.present?
      coordinates
    else
      CHICAGO_COORDINATES
    end
  end

  def autocomplete(options={})
    options.merge!(festival_id: festival_id)
    { restaurants: Restaurant.autocomplete_search(find, location, options),
      menu_items: MenuItem.autocomplete_search(find, location, options),
      neighborhoods: Neighborhood.autocomplete_search(near, location, options),
      cuisine_types: CUISINE_TYPES.select {|type| type.include?(find.to_s.downcase) } }
  end

  private

  def lookup_coordinates
    geocoder_str = case near
      when /chicago/i
        near
      else
        near + %q{ Chicago}
    end

    MultiGeocoder
      .geocode(geocoder_str)
      .ll
      .split(',')
      .map(&:to_f)
  end
end
