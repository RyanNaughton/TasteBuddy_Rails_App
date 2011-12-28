Factory.define :restaurant_menu, class: 'Restaurant::Menu' do |f|
  f.association :restaurant
end
