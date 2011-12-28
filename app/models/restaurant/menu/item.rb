class Restaurant::Menu::Item < ActiveRecord::Base
  belongs_to :restaurant_menu, class_name: 'Restaurant::Menu'
  belongs_to :boss_restaurant_menu_item, class_name: self.name
  validates_presence_of :restaurant_menu_id, :name
  serialize :prices
  has_many :pictures, foreign_key: 'menu_item_id'
  has_many :comments, class_name: 'Restaurant::Menu::Item::Comment', foreign_key: 'restaurant_menu_item_id'
  has_many :bookmarks, class_name: 'Restaurant::Menu::Item::Bookmark', foreign_key: 'restaurant_menu_item_id'
  has_many :ratings, class_name: 'Restaurant::Menu::Item::Rating', foreign_key: 'restaurant_menu_item_id'

  attr_accessor :price_keys, :price_values

  before_create :set_prices

  searchable(:auto_index => true) do
    text :name, :boost => 2.0
    integer :restaurant_id, references: Restaurant
  end

  def restaurant_id
    Restaurant.joins(:menu => :restaurant_menu_items).where(restaurant_menu_items: {restaurant_menu_id: self.restaurant_menu_id}).first.id
  end

  def set_prices
    if price.blank? and [price_keys, price_values].all?(&:present?)
      keys, values = [price_keys, price_values].map {|str| str.split(?|).map(&:strip) }

      values = case
        when values.any? {|value| value.to_f.zero? }
          Array.new(keys.length)
        else
          values.map(&:to_f)
      end

      self.prices = Hash[keys.zip(values)]
    end
  end

  def set_ratings_metadata
    ratings = ::Restaurant::Menu::Item::Rating.where(restaurant_menu_item_id: id)
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
