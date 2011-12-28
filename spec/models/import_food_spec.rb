require 'spec_helper'

describe ImportFood do
  describe '.import_csv' do
    it 'succeeds' do
      r = Factory(:restaurant_group).boss_restaurant
      csv_path = Rails.root.join(*%w{spec fixtures menu_data.csv}).to_s
      proc { ImportFood.import_csv(csv_path) }.should_not raise_error
    end
  end

  describe '.import_row' do
    it 'succeeds' do
      r = Factory(:restaurant_group).boss_restaurant
      attrs = {foursquare_v1: r.foursquare_v1, restaurant_name: r.name, item_name: 'Burger', item_price: 8.99, menu_section: 'Burgers', menu_subsection: 'Cooked Burgers'}
      proc { ImportFood.import_row(attrs) }.should_not raise_error
    end
  end
end
