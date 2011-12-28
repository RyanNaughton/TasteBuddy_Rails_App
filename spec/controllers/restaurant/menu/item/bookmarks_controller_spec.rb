require 'spec_helper'

describe Restaurant::Menu::Item::BookmarksController do
  context 'when the user is logged in' do
    before(:each) do
      @user = Factory(:user)
      @menu_item = Factory(:restaurant_menu_item)
      sign_in @user
    end

    def valid_attributes
      {user_id: @user.id, restaurant_menu_item_id: @menu_item.id}
    end

    describe 'POST create' do
      it 'creates a bookmark for the current user if none exists' do
        expect {
          post :create, :id => @menu_item.id.to_s
        }.to change(Restaurant::Menu::Item::Bookmark, :count).by(1)
      end
    end

    describe 'DELETE destroy' do
      it 'destroys a bookmark found for the current user and requested menu item' do
        Restaurant::Menu::Item::Bookmark.create! valid_attributes
        expect {
          delete :destroy, :id => @menu_item.id.to_s
        }.to change(Restaurant::Menu::Item::Bookmark, :count).by(-1)
      end

      it 'does nothing when no bookmark is found' do
        proc { delete :destroy, :id => @menu_item.id.to_s }.should_not raise_error
      end
    end
  end
end
