require 'spec_helper'

describe Restaurant::Menu::Item do
  it { should validate_presence_of(:restaurant_menu_id, :name) }

  context 'setting price options hash' do
    it 'sets custom price attributes on create' do
      menu = Factory(:restaurant_menu)
      entry_attributes = {restaurant_menu_id: menu.id, price_keys: 'sm | lg', price_values: '3 | 5'}
      entry = Restaurant::Menu::Item.create(entry_attributes)
      entry.prices.should eq Hash['sm' => 3, 'lg' => 5]
    end

    it 'sets values to nil if any are blank or zeroes' do
      menu = Factory(:restaurant_menu)
      entry_attributes = {restaurant_menu_id: menu.id, price_keys: 'reg', price_values: '0'}
      entry = Restaurant::Menu::Item.create(entry_attributes)
      entry.prices.should eq Hash['reg' => nil]
    end
  end
end
