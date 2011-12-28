object current_user

code(:restaurants) do
  partial 'restaurants/index', object: current_user.bookmarked_restaurants
end

code(:menu_items_by_restaurant) do
  current_user
    .bookmarked_menu_items
    .group_by(&:restaurant_id)
    .map do |rest_id, values|
      restaurant = Restaurant.find(rest_id)
      Hash[
        :restaurant_id => restaurant.id,
        :restaurant_name => restaurant.name,
        :menu_items => partial('restaurant/menu/items/index', object: values)
      ]
    end
end
