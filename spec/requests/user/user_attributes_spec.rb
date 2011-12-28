require 'spec_helper'

describe 'User::Attributes' do
  describe 'GET /user_attributes' do
    it 'works' do
      pending()
      get user_attributes_path
      response.status.should be(200)
    end
  end
end
