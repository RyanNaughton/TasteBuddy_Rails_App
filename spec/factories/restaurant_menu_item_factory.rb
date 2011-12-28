Factory.define :restaurant_menu_item, class: 'Restaurant::Menu::Item' do |f|
  f.name 'Cookie plate'
  f.association :restaurant_menu
end
