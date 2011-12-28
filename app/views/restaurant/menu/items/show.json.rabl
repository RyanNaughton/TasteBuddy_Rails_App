object @restaurant_menu_item
attributes :id, :restaurant_id, :name, :foreign_name, :description, :price, :ticket_price
attributes :average_rating, :ratings_count

code(:pictures) do |restaurant_menu_item|
  partial('pictures/index', object: restaurant_menu_item.pictures)
end

code(:tags) { Hash.new }
code(:comments) do |item|
  partial 'restaurant/menu/item/comments/index', object: item.comments
end
 
if current_user
  code(:bookmark) do |restaurant_menu_item|
    restaurant_menu_item.bookmarks.where(user_id: current_user.try(:id)).exists?
  end
  
  code(:user_rating) do |restaurant_menu_item|
    user_rating_obj = restaurant_menu_item.ratings.find_by_user_id(current_user.try(:id))
    user_rating_obj.present? ? user_rating_obj.value : nil
  end
end
