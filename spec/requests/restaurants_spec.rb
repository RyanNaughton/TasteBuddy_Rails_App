require 'spec_helper'

describe 'Restaurants' do
  describe 'GET /restaurants' do
    it 'works' do
      get restaurants_path
      response.status.should be(200)
    end
  end
end
