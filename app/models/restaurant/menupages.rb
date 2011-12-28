require_dependency File.expand_path('../../restaurant', __FILE__)

module Restaurant::Menupages
  def menupages_menu
    menupages_url.present? or raise ArgumentError, 'menupages_url required'
    ::MenuScrape::Client
      .new(endpoint: menupages_url)
      .menu_data
  end

  COLUMNS = [:restaurant_foursquare_v1, :restaurant_name, :restaurant_address, :menu_section, :menu_subsection, :item_number, :item_name, :item_prices, :item_description].freeze

  def menupages_menu_csv
    CSV.generate do |csv|
      csv << COLUMNS
      menupages_menu.each do |section|
        menu_section = section[:name]
        menu_section_description = section[:description]
        section[:subcategories].to_a.each do |subsection|
          menu_subsection = subsection[:name]
          subsection[:items].to_a.each do |item|
            menu_item = item[:name]
            menu_item_prices = item[:prices].blank? ? nil : item[:prices].map(&:to_s).join(%q{|})
            menu_item_description = item[:description]
            csv << [foursquare_v1, name, address_1, menu_section, menu_subsection, nil, menu_item, menu_item_prices, menu_item_description]
          end
        end
      end
    end
  end
end
