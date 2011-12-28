class Restaurant::Rating < ActiveRecord::Base
  validates_presence_of :value, :restaurant_id, :user_id

  belongs_to :restaurant, class_name: 'Restaurant'

  after_save :update_parent_metadata

  def update_parent_metadata
    restaurant.set_ratings_metadata
    restaurant.save
  end
end
