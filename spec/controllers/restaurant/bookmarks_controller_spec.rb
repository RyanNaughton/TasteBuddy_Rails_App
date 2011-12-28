require 'spec_helper'

describe Restaurant::BookmarksController do
  context 'when the user is logged in' do
    before(:each) do
      @user = Factory(:user)
      @restaurant = Factory(:restaurant)
      sign_in @user
    end

    def valid_attributes
      {user_id: @user.id, restaurant_id: @restaurant.id}
    end

    describe 'POST create' do
      it 'creates a bookmark for the specified restaurant if none exists' do
        expect {
          post :create, :id => @restaurant.id.to_s
        }.to change(Restaurant::Bookmark, :count).by(1)
      end
    end

    describe 'DELETE destroy' do
      it 'destroys a bookmark found for the current user and requested restaurant' do
        Restaurant::Bookmark.create! valid_attributes
        expect {
          delete :destroy, :id => @restaurant.id.to_s
        }.to change(Restaurant::Bookmark, :count).by(-1)
      end

      it 'does nothing when no bookmark is found' do
        proc { delete :destroy, :id => @restaurant.id.to_s }.should_not raise_error
      end
    end
  end
end
