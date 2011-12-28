object @restaurant
attributes :id, :name, :website_url, :alcohol_type, :byob, :credit_cards, :delivery, :delivery_details, :delivery_fee, :delivery_minimum, :delivery_radius, :dress_code, :group_friendly, :jukebox, :kid_friendly, :live_music, :live_music_details, :outdoor_seating, :parking, :parking_details, :reservations, :smoking, :takeout, :wheelchair_access, :wifi, :additional_details
attributes :phone, :fax, :address_description, :address_1, :address_2, :city_town, :state_province, :postal_code, :country, :nearest_transit, :neighborhood, :location

attributes :average_rating, :ratings_count, :distance

code(:distance, :if => lambda {|restaurant| restaurant.try(:distance).present? }) {|restaurant| restaurant.distance }

code(:pictures) do |restaurant|
  partial('pictures/index', object: restaurant.pictures)
end

code(:cuisine_types) {|r| r.cuisine_type.present? ? [r.cuisine_type] : ['American'] }
code(:tags) { Hash.new }
code(:hours) { nil }
code(:menu_present) {|r| r.menu.present? }
code(:comments) do |restaurant|
  partial 'restaurant/comments/index', object: restaurant.comments
end

code(:menu_items) do |restaurant|
  partial('restaurant/menu/items/index', object: restaurant.menu_items.to_a)
end 

if current_user
  code(:bookmark) do |restaurant|
    restaurant.bookmarks.where(user_id: current_user.try(:id)).exists?
  end

  code(:user_rating) do |restaurant|
    user_rating_obj = restaurant.ratings.find_by_user_id(current_user.id)
    user_rating_obj.present? ? user_rating_obj.value : nil
  end
end
