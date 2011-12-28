# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

ActiveRecord::Base.transaction do

  User.create do |user|
    user.username = 'admin'
    user.email = 'admin@example.com'
    user.password = 'banana'
    user.password_confirmation = 'banana'
    user.add_role(:admin)
  end

  if Neighborhood.count.zero?
    neighborhoods_data_path = Rails.root.join(*%w(db seed_data neighborhoods.csv))
    CSV.foreach(neighborhoods_data_path, :headers => true) do |row|
      Neighborhood.create!(row.to_hash)
    end
  end

  taste_of_chicago = Festival.create! do |f|
    f.name = 'Taste of Chicago'
    f.address_description = 'Grant Park'
    f.address_1 = '337 E Randolph St'
    f.city_town = 'Chicago'
    f.state_province = 'IL'
    f.postal_code = '60601'
    f.website_url = 'http://www.explorechicago.org/city/en/supporting_narrative/events___special_events/special_events/park_district/Taste_of_Chicago.html'
    f.latitude = 41.24
    f.longitude = -87.65
    f.start_date = '2011-06-24'
    f.end_date = '2011-07-04'
    f.ticket_cost = 0.75
  end

  Festival::HeaderColor.create!(festival_id: taste_of_chicago.id, red: 126, green: 280, blue: 230)
  Festival::Logo.create!(
    festival_id: taste_of_chicago.id,
    low_resolution: 'http://dl.dropbox.com/u/15391609/taste_buddy/festival_logos/tasteOfChicago.png',
    standard_resolution: 'http://dl.dropbox.com/u/15391609/taste_buddy/festival_logos/tasteOfChicago@2x.png'
  )

  restaurants_data_path = Rails.root.join(*%w(db seed_data restaurants.csv))
  CSV.foreach(restaurants_data_path, :headers => true) do |rest_row|
    Restaurant.create(rest_row.to_hash) || fail(RuntimeError, "Error creating Restaurant: #{row.to_hash.inspect}")
  end

  festival_booths_data_path = Rails.root.join(*%w(db seed_data festival_booths.csv))
  CSV.foreach(festival_booths_data_path, :headers => true) do |festival_row|
    attrs = festival_row.to_hash
    boss_foursquare_v1 = attrs.delete('boss_foursquare_v1')
    boss_restaurant = (Restaurant.find_by_foursquare_v1(boss_foursquare_v1) || Restaurant.find_by_name(attrs['name']))
    boss_restaurant.present? or fail(RuntimeError, "No boss Restaurant: #{row.to_hash.inspect}")
    attrs.merge!(boss_restaurant_id: boss_restaurant.id)
    Restaurant.create(attrs) || fail(RuntimeError, "Error creating festival booth Restaurant: #{row.to_hash.inspect}")
  end

  ImportFood.import_csv(Rails.root.join(*%w(db seed_data menus.csv)))
end
