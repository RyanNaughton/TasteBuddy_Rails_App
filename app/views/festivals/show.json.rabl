object @festival

attributes :id, :name, :address_description, :address_1, :city_town, :state_province
attributes :start_date, :end_date, :ticket_cost


code(:distance) {|festival| festival.distance_to(@coordinates) }
code(:logo) {|festival| festival.logo.as_json }
code(:header_color) {|festival| festival.header_color.as_json }
