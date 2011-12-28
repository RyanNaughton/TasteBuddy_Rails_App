class Restaurant::Group < ActiveRecord::Base
  belongs_to :boss_restaurant, class_name: 'Restaurant'
  has_many :restaurants, foreign_key: 'restaurant_group_id'
  validates_presence_of :name, :boss_restaurant_id
  validates_associated :boss_restaurant

  before_validation :copy_name_if_associated_boss_restaurant_present, on: :create
  after_create :set_group_id_in_associated_boss_restaurant
  after_destroy :reset_group_id_in_associated_boss_restaurant

  def copy_name_if_associated_boss_restaurant_present
    name.blank? && boss_restaurant and self.name = boss_restaurant.name
    true
  end

  def set_group_id_in_associated_boss_restaurant
    boss_restaurant.update_attribute(:restaurant_group_id, id)
  end

  def reset_group_id_in_associated_boss_restaurant
    boss_restaurant.update_attribute(:restaurant_group_id, nil)
  end

  def junior_restaurants
    restaurants - [boss_restaurant]
  end

  def self.valid_boss_restaurants
    Restaurant
      .where('foursquare_v1 IS NOT NULL')
      .where('group_id IS NULL')
  end
end
