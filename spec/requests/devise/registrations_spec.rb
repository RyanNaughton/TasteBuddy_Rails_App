require 'spec_helper'

describe 'Devise::Registrations' do
  before(:each) do
    @user = Factory(:user)
  end

  describe 'GET /users/edit.json' do
    it 'works' do
      get '/users/edit', auth_token: @user.authentication_token, format: 'json'
      response.status.should be(200)
    end
  end
end
