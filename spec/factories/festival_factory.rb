Factory.define :festival do |f|
  f.name 'Generic Festival'
end

Factory.define :taste_of_chicago, class: 'Festival' do |f|
  f.name 'Taste of Chicago'
  f.address_description 'Grant Park'
  f.address_1 '337 E Randolph St'
  f.city_town 'Chicago'
  f.state_province 'IL'
  f.postal_code '60601'
  f.website_url 'http://www.explorechicago.org/city/en/supporting_narrative/events___special_events/special_events/park_district/Taste_of_Chicago.html'
  f.latitude 41.24
  f.longitude -87.65
  f.start_date '2011-06-24'
  f.end_date '2011-07-04'
  f.ticket_cost 0.75
end
