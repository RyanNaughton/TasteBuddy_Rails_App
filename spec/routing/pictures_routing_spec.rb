require 'spec_helper'

describe PicturesController do
  describe 'routing' do

    it 'routes to #index' do
      get('/pictures').should route_to('pictures#index')
    end

    it 'routes to #new' do
      get('/pictures/new').should route_to('pictures#new')
    end

    it 'routes to #show' do
      get('/pictures/1').should route_to('pictures#show', :id => '1')
    end

    it 'routes to #edit' do
      get('/pictures/1/edit').should route_to('pictures#edit', :id => '1')
    end

    it 'routes to #create' do
      post('/pictures').should route_to('pictures#create')
    end

    it 'routes to #update' do
      put('/pictures/1').should route_to('pictures#update', :id => '1')
    end

    it 'routes to #destroy' do
      delete('/pictures/1').should route_to('pictures#destroy', :id => '1')
    end

  end
end
