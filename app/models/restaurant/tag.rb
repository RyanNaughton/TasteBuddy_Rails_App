class Restaurant::Tag < ActiveRecord::Base
  validates_presence_of :restaurant_id, :authorized_tag_id, :user_id
end
