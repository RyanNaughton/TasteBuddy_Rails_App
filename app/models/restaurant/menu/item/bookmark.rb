class Restaurant::Menu::Item::Bookmark < ActiveRecord::Base
  belongs_to :restaurant_menu_item, class_name: 'Restaurant::Menu::Item'
  belongs_to :user
  validates_presence_of :user_id, :restaurant_menu_item_id
end
