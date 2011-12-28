class Restaurant::Menu < ActiveRecord::Base
  belongs_to :restaurant, class_name: 'Restaurant'
  has_many :restaurant_menu_items, class_name: 'Restaurant::Menu::Item', foreign_key: 'restaurant_menu_id'
  has_many :menu_items, foreign_key: 'restaurant_menu_id'
  validates_presence_of :restaurant_id
end
