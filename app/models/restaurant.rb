class Restaurant < ActiveRecord::Base
  include Grubhub
  include Menupages
  include Yelp
  include Instagram

  belongs_to :restaurant_group, class_name: 'Restaurant::Group'
  belongs_to :boss_restaurant, class_name: self.name
  has_one :menu, class_name: 'Restaurant::Menu'
  has_many :bookmarks, class_name: 'Restaurant::Bookmark'
  has_many :comments, class_name: 'Restaurant::Comment'
  has_many :ratings, class_name: 'Restaurant::Rating'
  has_many :pictures
  has_many :restaurant_menu_items, class_name: 'Restaurant::Menu::Item'

  validates_presence_of :name
  validates_uniqueness_of :yelp_url, :menupages_url, allow_blank: true

  NORMALIZED_ATTRIBUTES = columns.select {|c| c.type == :string }.map(&:name).map(&:intern).freeze
  normalize_attributes *NORMALIZED_ATTRIBUTES

  attr_accessor :distance
  attr_accessor :menu_items

  def menu_items
    @menu_items.present? ? @menu_items : []
  end

  searchable(auto_index: true) do
    text :name, :cuisine_type, :menu_item_names
    integer :festival_id
    location :coordinates do
      Sunspot::Util::Coordinates.new(latitude, longitude)
    end
  end

  def menu_item_names # for indexing
    Restaurant::Menu::Item
      .joins(restaurant_menu: :restaurant)
      .where(restaurants: {id: id})
      .select('restaurant_menu_items.name')
      .map(&:name)
      .uniq
  end

  CHICAGO = [41.881944, -87.627778].freeze

  def self.grouped_unrestricted_menu_item_search(query, search_restaurant_ids, options={})
    options = {page: 1, per_page: 10_000}.merge(options)
    menu_item_ids = MenuItem.solr_search_ids {
      with(:restaurant_id).any_of(search_restaurant_ids)
      keywords(query) {minimum_match query.strip.blank? ? 0 : 1}
      paginate page: options[:page], per_page: options[:per_page]
    }

    MenuItem
      .includes(comments: :user, pictures: :user)
      .find(menu_item_ids)
      .group_by {|item| item.read_attribute(:restaurant_id) }
      .to_hash
  end

  def self.grouped_menu_item_search(query, search_restaurant_ids)
    options = {page: 1, per_page: 3}.merge(options={})
    
    menu_item_ids = search_restaurant_ids.map do |restaurant_id|
      MenuItem.solr_search_ids {
        with(:restaurant_id, restaurant_id)
        keywords(query) {minimum_match (query.strip.blank? ? 0 : 1)}
        paginate page: options[:page], per_page: options[:per_page]
      }
    end.flatten

    MenuItem
      .includes(pictures: :user, comments: :user)
      .find(menu_item_ids)
      .group_by {|item| item.read_attribute(:restaurant_id) }
      .to_hash
  end

  def self.search(query, coordinates=CHICAGO, options={})
    if options[:festival_id].to_i.nonzero?
      default_options = {page: 1, per_page: 60} # all booths
    else
      default_options = {page: 1, per_page: 30}
    end

    options = default_options.merge(options)

    restaurant_ids = self.solr_search_ids {
      keywords(query)
      if options[:festival_id].to_i.nonzero?
        with(:festival_id, options[:festival_id].to_i)
      end
      with(:coordinates).near(*coordinates, :precision => 3)
      paginate page: options[:page], per_page: options[:per_page]
    }

    grouped_menu_items = if options[:festival_id]
      grouped_unrestricted_menu_item_search(query, restaurant_ids)
    else
      grouped_menu_item_search(query, restaurant_ids)
    end

    Restaurant
      .includes(pictures: :user, comments: :user)
      .find(restaurant_ids)
      .map do |result|
        result.distance_to(coordinates)
        result.menu_items = grouped_menu_items[result.id].to_a
        result
      end
      .sort_by(&:distance)
  end

  def self.autocomplete_search(query, coordinates=CHICAGO, options={})
    options = {page: 1, per_page: 100}.merge(options)
    restaurant_ids = self.solr_search_ids {
      keywords(query)
      if options[:festival_id].to_i.nonzero?
        with(:festival_id, options[:festival_id].to_i)
      else
        with(:coordinates).near(*coordinates, :precision => 3)
      end
      paginate(page: options[:page], per_page: options[:per_page])
    }
    connection.select_values(
      self.select('DISTINCT(name)').where(id: restaurant_ids).to_sql
    ).map(&:strip)
  end

  def distance_to(coordinates)
    Haversine
      .distance(latitude.to_f, longitude.to_f, *coordinates)[:miles]
      .number
      .tap {|number| @distance = number.round(2) }
  end

  def selection_identifier
    [foursquare_v1, name, address_1, city_town, state_province].compact.join(%q{, })
  end

  def foursquare_url
    return nil if foursquare_v1.blank?
    "https://foursquare.com/venue/#{foursquare_v1}"
  end

  def location
    loc = [latitude, longitude]
    loc.compact.blank? ? nil : loc
  end

  def set_ratings_metadata
    self.ratings_count = ratings.count
    self.average_rating = case ratings_count
      when 0
        nil
      else
        ratings
          .map(&:value)
          .inject(0) {|s,v| s + v }
          ./(ratings_count.to_f)
          .round(1)
    end
  end
end
