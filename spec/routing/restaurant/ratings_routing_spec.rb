require 'spec_helper'

describe Restaurant::RatingsController do
  describe 'routing' do

    it 'routes to #create' do
      post('/restaurants/1/rate').should route_to('restaurant/ratings#create', id: '1')
       put('/restaurants/1/rate').should route_to('restaurant/ratings#create', id: '1')
    end

  end
end
