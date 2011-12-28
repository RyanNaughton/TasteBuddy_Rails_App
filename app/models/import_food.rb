require 'csv'

module ImportFood
  def self.import_csv(filepath)
    count = 0
    ActiveRecord::Base.transaction do # all or none
      CSV.foreach(filepath, headers: true, encoding: 'utf-8') do |row|
        import_row(row.to_hash)
      end
    end
  end

  def self.festival_names
    @names ||= Festival.all.map(&:name)
  end

  NON_BLOCKING_SPACE = "\u00A0".freeze
  SPACE = %q{ }.freeze

  def self.import_row(attrs)
    attrs = HashWithIndifferentAccess.new(attrs)
    attrs.keys.each do |key|
      if ! attrs[:key].nil?
        attrs[:key].gsub!(NON_BLOCKING_SPACE, SPACE)
        attrs[:key].strip!
        attrs[:key].blank? and attrs[:key] = nil
      end
    end

    restaurant_scope = Restaurant.includes(:boss_restaurant)

    if ! (parent_restaurant = restaurant_scope.find_by_name_and_address_1(attrs[:restaurant_name], attrs[:restaurant_address]))
      parent_restaurant = case Restaurant.where(foursquare_v1: attrs[:restaurant_foursquare_v1]).count
        when 0 then raise RuntimeError, "no restaurant match found for foursquare_v1=#{attrs[:restaurant_foursquare_v1]}"
        when 1 then restaurant_scope.find_by_foursquare_v1!(attrs[:restaurant_foursquare_v1])
        else
          restaurant_scope.find_by_foursquare_v1_and_name!(attrs[:restaurant_foursquare_v1], attrs[:restaurant_name])
      end
    end

    if festival_names.include?(attrs[:menu_section]) # 'Taste of Chicago'
      attrs[:menu_subsection] = nil # force one level of organization
      restaurant = Restaurant.where('booth_number IS NOT NULL').find_by_boss_restaurant_id(parent_restaurant.id)
      restaurant.blank? and raise(RuntimeError, "missing restaurant booth: restaurant_foursquare_v1=#{attrs[:restaurant_foursquare_v1]}")
    else
      restaurant = parent_restaurant
    end

    boss_menu_item = Restaurant::Menu::Item.joins(restaurant_menu: :restaurant).where(restaurant_menu_items: {name: attrs[:item_name]}).where(restaurants: {id: parent_restaurant.id}).first
    menu = Restaurant::Menu.find_or_create_by_restaurant_id(restaurant.id)

    Restaurant::Menu::Item.where(restaurant_menu_id: menu.id, section: attrs[:menu_section], subsection: attrs[:menu_subsection], name: attrs[:name]).first or
      Restaurant::Menu::Item.create!(restaurant_menu_id: menu.id, section: attrs[:menu_section], subsection: attrs[:menu_subsection], number: attrs[:item_number], name: attrs[:item_name], foreign_name: attrs[:item_foreign_name], alternative_name: attrs[:item_alternative_name], description: attrs[:item_description], tags: attrs[:item_tags], category_values: attrs[:item_category_values], price_selector: attrs[:price_selector], cpg: attrs[:cpg], price: attrs[:item_price], price_keys: attrs[:item_price_keys], price_values: attrs[:item_price_values], ticket_price: attrs[:item_ticket_price])
  end
end
