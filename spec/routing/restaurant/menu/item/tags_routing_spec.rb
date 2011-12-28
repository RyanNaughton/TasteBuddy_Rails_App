require 'spec_helper'

describe Restaurant::Menu::Item::TagsController do
  describe 'routing' do

    it 'routes to #create' do
      post('/menu_items/1/tag').should route_to('restaurant/menu/item/tags#create', id: '1')
       put('/menu_items/1/tag').should route_to('restaurant/menu/item/tags#create', id: '1')
    end

    it 'routes to #destroy' do
      delete('/menu_items/1/tag').should route_to('restaurant/menu/item/tags#destroy', id: '1')
    end

  end
end
