Factory.define :restaurant_menu_item_comment, class: 'Restaurant::Menu::Item::Comment' do |f|
  f.text 'Extra special.'
  f.restaurant_menu_item_id 1
  f.user_id 1
end
