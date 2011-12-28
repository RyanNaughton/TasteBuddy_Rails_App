require 'spec_helper'

describe 'Restaurant::Groups' do
  describe 'GET /restaurant_groups' do
    it 'works' do
      get restaurant_groups_path
      response.status.should be(200)
    end
  end
end
