require 'spec_helper'

describe Restaurant::RatingsController do
  context 'when the user is logged in' do
    before(:each) do
      @user = Factory(:user)
      @restaurant = Factory(:restaurant)
      sign_in @user
    end

    def request_attributes
      {user_id: @user.id, id: @restaurant.id, value: 4}
    end

    def object_attributes
      {user_id: @user.id, restaurant_id: @restaurant.id, value: 4}
    end

    describe 'POST create' do
      describe 'with valid params' do
        describe 'when no rating exists' do
          it 'creates a new Restaurant::Rating' do
            expect {
              post :create, request_attributes
            }.to change(Restaurant::Rating, :count).by(1)
          end

          it 'assigns a newly created rating as @restaurant_rating' do
            post :create, request_attributes
            assigns(:restaurant_rating).should be_a(Restaurant::Rating)
            assigns(:restaurant_rating).should be_persisted
          end
        end

        describe 'when a rating exists for the current user and specified menu item' do
          it 'updates the requested rating' do
            rating = Restaurant::Rating.create! object_attributes
            Restaurant::Rating.any_instance.should_receive(:value=).with(2)
            put :create, request_attributes.merge(value: 2)
          end

          it 'assigns the requested rating as @restaurant_rating' do
            rating = Restaurant::Rating.create! object_attributes
            post :create, request_attributes
            assigns(:restaurant_rating).should eq(rating)
          end
        end
      end
    end
  end
end
