require 'spec_helper'

describe Restaurant::Menu::Item::CommentsController do
  describe 'routing' do

    it 'routes to #create' do
      post('/menu_items/1/comment').should route_to('restaurant/menu/item/comments#create', id: '1')
       put('/menu_items/1/comment').should route_to('restaurant/menu/item/comments#create', id: '1')
    end

  end
end
