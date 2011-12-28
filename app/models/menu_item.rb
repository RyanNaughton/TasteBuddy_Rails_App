class MenuItem < ActiveRecord::Base
  set_table_name 'restaurant_menu_items'

  belongs_to :restaurant_menu, class_name: 'Restaurant::Menu'
  belongs_to :boss_restaurant_menu_item, class_name: self.name
  validates_presence_of :restaurant_menu_id, :name
  serialize :prices
  has_many :pictures, foreign_key: 'menu_item_id'
  has_many :comments, class_name: 'Restaurant::Menu::Item::Comment', foreign_key: 'restaurant_menu_item_id'
  has_many :bookmarks, class_name: 'Restaurant::Menu::Item::Bookmark', foreign_key: 'restaurant_menu_item_id'
  has_many :ratings, class_name: 'Restaurant::Menu::Item::Rating', foreign_key: 'restaurant_menu_item_id'
  belongs_to :restaurant

  attr_accessor :price_keys, :price_values

  before_create :set_prices

  searchable(auto_index: true) do
    text :name, boost: 2.0
    integer :restaurant_id, references: Restaurant
  end

  CHICAGO = [41.881944, -87.627778].freeze

  def self.autocomplete_search(query, coordinates=CHICAGO, options={})
    options = {page: 1, per_page: 100}.merge(options)
    item_ids = self.solr_search_ids {
      keywords(query)
      if options[:festival_id].to_i.nonzero?
        restaurant_ids = Restaurant.connection.select_values(Restaurant.select(:id).where(festival_id: options[:festival_id]).limit(options[:per_page]).to_sql).map(&:to_i)
        with(:restaurant_id).any_of(restaurant_ids)
      end
      paginate page: options[:page], per_page: options[:per_page]
    }
    connection.select_values(
      self.select('DISTINCT(name)').where(id: item_ids).to_sql
    ).map(&:strip)
  end

  def restaurant_id
    read_attribute(:restaurant_id) or restaurant_menu.restaurant_id
  end
end
