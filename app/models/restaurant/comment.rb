class Restaurant::Comment < ActiveRecord::Base
  validates_presence_of :restaurant_id, :user_id
  validates_length_of :text, within: 2..140
  belongs_to :user
end
