# -*- encoding: utf-8 -*-

Factory.define :restaurant do |f|
  f.name 'Un restaurant générique'
  f.foursquare_v1 1
# f.association :restaurant_group
end

Factory.define :blackbird, class: 'Restaurant' do |f|
  f.name 'Blackbird'
  f.foursquare_v1 45062
# f.instagram_v1 '676535'
end

Factory.define :chicago_joes, class: 'Restaurant' do |f|
  f.name "Chicago Joe's"
  f.foursquare_v1 306878
  f.grubhub_url 'http://www.grubhub.com/chicago/chicago-joes/'
  f.menupages_url 'http://chicago.menupages.com/restaurants/chicago-joes/'
  f.address_1 '2256 W Irving Park Rd'
  f.city_town 'Chicago'
  f.state_province 'IL'
end
