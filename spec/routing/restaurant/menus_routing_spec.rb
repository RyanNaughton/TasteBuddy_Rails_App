require 'spec_helper'

describe Restaurant::MenusController do
  describe 'routing' do

    it 'routes to #show' do
      get('/restaurants/1/menu').should route_to('restaurant/menus#show', id: '1')
    end

    it 'routes to #grubhub' do
      get('/restaurants/1/menus/grubhub').should route_to('restaurant/menus#grubhub', id: '1')
    end

    it 'routes to #menupages' do
      get('/restaurants/1/menus/menupages').should route_to('restaurant/menus#menupages', id: '1')
    end

  end
end
