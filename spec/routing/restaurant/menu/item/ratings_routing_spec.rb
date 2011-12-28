require 'spec_helper'

describe Restaurant::Menu::Item::RatingsController do
  describe 'routing' do

    it 'routes to #create' do
      post('/menu_items/1/rate').should route_to('restaurant/menu/item/ratings#create', id: '1')
       put('/menu_items/1/rate').should route_to('restaurant/menu/item/ratings#create', id: '1')
    end

  end
end
