require 'spec_helper'

describe Restaurant::Menu::Item::BookmarksController do
  describe 'routing' do

    it 'routes to #create with POST and PUT' do
      post('/menu_items/1/bookmark').should route_to('restaurant/menu/item/bookmarks#create', id: '1')
       put('/menu_items/1/bookmark').should route_to('restaurant/menu/item/bookmarks#create', id: '1')
    end

    it 'routes to #destroy' do
      delete('/menu_items/1/bookmark').should route_to('restaurant/menu/item/bookmarks#destroy', id: '1')
    end

  end
end
