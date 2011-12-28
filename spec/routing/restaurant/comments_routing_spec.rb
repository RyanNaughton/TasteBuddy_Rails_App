require 'spec_helper'

describe Restaurant::CommentsController do
  describe 'routing' do

    it 'routes to #create' do
      post('/restaurants/1/comment').should route_to('restaurant/comments#create', id: '1')
       put('/restaurants/1/comment').should route_to('restaurant/comments#create', id: '1')
    end

  end
end
