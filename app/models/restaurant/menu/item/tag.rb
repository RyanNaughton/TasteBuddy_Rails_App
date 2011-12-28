class Restaurant::Menu::Item::Tag < ActiveRecord::Base
  validates_presence_of :restaurant_menu_item_id, :authorized_tag_id, :user_id
end
