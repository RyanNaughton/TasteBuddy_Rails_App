require 'spec_helper'

describe 'Restaurant::Menus' do
  describe 'GET /restaurants/1/menu' do
    it 'works' do
      @restaurant_menu = Factory(:restaurant_menu)
      get restaurant_menu_path(@restaurant_menu.restaurant)
      response.status.should be(200)
    end
  end
end
