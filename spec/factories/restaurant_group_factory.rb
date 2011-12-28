Factory.define :restaurant_group, class: 'Restaurant::Group' do |f|
  f.name 'Pidgin Restaurants'
  f.association :boss_restaurant, factory: :restaurant
end
