require 'spec_helper'

describe User::AttributesController do
  describe 'routing' do

    it 'routes to #update' do
      put('users/update').should route_to('user/attributes#update')
    end

    it 'routes to #update' do
      get('users/profile').should route_to('user/attributes#profile')
    end

    it 'routes to #bookmarks' do
      get('users/bookmarks').should route_to('user/attributes#bookmarks')
    end

  end
end
