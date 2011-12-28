class Restaurant::Menu::Item::Rating < ActiveRecord::Base
  validates_presence_of :value, :restaurant_menu_item_id, :user_id
  belongs_to :restaurant_menu_item, class_name: 'Restaurant::Menu::Item'

  after_save :update_parent_metadata

  def update_parent_metadata
    restaurant_menu_item.set_ratings_metadata
    restaurant_menu_item.save
  end
end
