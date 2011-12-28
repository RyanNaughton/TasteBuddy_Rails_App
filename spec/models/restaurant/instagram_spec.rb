require 'spec_helper'

describe Restaurant::Instagram do
  before(:each) do
    @restaurant = Factory(:blackbird)
  end

  describe '#ensure_instagram_v1', :if => :network_available do
    it 'sets and return instagram_v1 after querying with the foursquare_v1 attribute' do
      @restaurant.ensure_instagram_v1.should eq '676535'
    end

    it 'returns instagram_v1 if it is already set' do
      @restaurant.instagram_v1 = '42'
      @restaurant.ensure_instagram_v1.should eq '42'
    end

    it 'raises error if foursquare_v1 is not present' do
      @restaurant.foursquare_v1 = nil
      proc { @restaurant.ensure_instagram_v1 }.should raise_error ArgumentError, 'foursquare_v1 required'
    end
  end
end
