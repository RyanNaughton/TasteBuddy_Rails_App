Factory.define :restaurant_comment, class: 'Restaurant::Comment' do |f|
  f.text 'Extra special.'
  f.restaurant_id 1
  f.user_id 1
end
