require 'spec_helper'

describe Restaurant::GroupsController do
  describe 'routing' do

    it 'routes to #index' do
      get('/restaurant_groups').should route_to('restaurant/groups#index')
    end

    it 'routes to #new' do
      get('/restaurant_groups/new').should route_to('restaurant/groups#new')
    end

    it 'routes to #show' do
      get('/restaurant_groups/1').should route_to('restaurant/groups#show', :id => '1')
    end

    it 'routes to #edit' do
      get('/restaurant_groups/1/edit').should route_to('restaurant/groups#edit', :id => '1')
    end

    it 'routes to #create' do
      post('/restaurant_groups').should route_to('restaurant/groups#create')
    end

    it 'routes to #update' do
      put('/restaurant_groups/1').should route_to('restaurant/groups#update', :id => '1')
    end

    it 'routes to #destroy' do
      delete('/restaurant_groups/1').should route_to('restaurant/groups#destroy', :id => '1')
    end

  end
end
