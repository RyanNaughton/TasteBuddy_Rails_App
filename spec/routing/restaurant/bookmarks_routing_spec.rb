require 'spec_helper'

describe Restaurant::BookmarksController do
  describe 'routing' do

    it 'routes to #create with POST and PUT' do
      post('/restaurants/1/bookmark').should route_to('restaurant/bookmarks#create', id: '1')
       put('/restaurants/1/bookmark').should route_to('restaurant/bookmarks#create', id: '1')
    end

    it 'routes to #destroy' do
      delete('/restaurants/1/bookmark').should route_to('restaurant/bookmarks#destroy', id: '1')
    end

  end
end
