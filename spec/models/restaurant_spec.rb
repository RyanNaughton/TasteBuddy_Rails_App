require 'spec_helper'

describe Restaurant do
  it { should validate_presence_of(:name) }
  it {
    Factory(:restaurant, yelp_url: 'http://www.yelp.com/biz/blackbird-chicago', menupages_url: 'http://chicago.menupages.com/restaurants/blackbird/')
    should validate_uniqueness_of(:yelp_url, :menupages_url, allow_blank: true)
  }

  Restaurant::NORMALIZED_ATTRIBUTES.each do |normalized_attribute|
    it { should normalize_attribute(normalized_attribute).from(%q{ }).to(nil) }
  end

  describe '#selection_identifier' do
    it 'joins the foursquare_v1 and the present address attributes (including name)' do
      restaurant = Factory(:restaurant, foursquare_v1: '10011010', name: 'Generic', address_1: '1 Muni Plz')
      restaurant.selection_identifier.should eq '10011010, Generic, 1 Muni Plz'
    end
  end
end
