class Restaurant::Bookmark < ActiveRecord::Base
  belongs_to :restaurant, class_name: 'Restaurant'
  belongs_to :user
  validates_presence_of :user_id, :restaurant_id
end
