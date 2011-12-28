require_dependency File.expand_path('../../restaurant', __FILE__)

module Restaurant::Grubhub
  def grubhub_menu
    grubhub_url.present? or raise ArgumentError, 'grubhub_url required'
    ::GrubScrape::Client
      .new(endpoint: grubhub_url)
      .menu_data
  end

  COLUMNS = [:restaurant_foursquare_v1, :restaurant_name, :restaurant_address, :menu_section, :menu_subsection, :item_number, :item_name, :item_price, :item_price_values, :item_price_keys, :item_description].freeze

  def grubhub_menu_csv
    CSV.generate do |csv|
      csv << COLUMNS
      grubhub_menu.each do |item|
        csv << [foursquare_v1, name, address_1, 'GrubHub', item[:menu_section], nil, item[:item_name], item[:item_price], nil, nil, item[:item_description]]
      end
    end
  end
end
