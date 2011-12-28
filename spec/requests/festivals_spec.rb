require 'spec_helper'

describe 'Festivals' do
  describe 'GET /festivals' do
    it 'works' do
      get festivals_path
      response.status.should be(200)
    end
  end
end
