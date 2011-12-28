require 'spec_helper'

describe RestaurantsController do
  context 'when the user is an admin' do
    before do
      sign_in Factory(:admin)
    end

    def valid_attributes
      Factory.build(:restaurant).attributes
    end

    describe 'GET index' do
      it 'assigns all restaurants as @restaurants' do
        restaurant = Restaurant.create! valid_attributes
        get :index
        assigns(:restaurants).should eq([restaurant])
      end
    end

    describe 'GET show' do
      it 'assigns the requested restaurant as @restaurant' do
        restaurant = Restaurant.create! valid_attributes
        get :show, :id => restaurant.id.to_s
        assigns(:restaurant).should eq(restaurant)
      end
    end

    describe 'GET new' do
      it 'assigns a new restaurant as @restaurant' do
        get :new
        assigns(:restaurant).should be_a_new(Restaurant)
      end
    end

    describe 'GET edit' do
      it 'assigns the requested restaurant as @restaurant' do
        restaurant = Restaurant.create! valid_attributes
        get :edit, :id => restaurant.id.to_s
        assigns(:restaurant).should eq(restaurant)
      end
    end

    describe 'POST create' do
      describe 'with valid params' do
        it 'creates a new Restaurant' do
          expect {
            post :create, :restaurant => valid_attributes
          }.to change(Restaurant, :count).by(1)
        end

        it 'assigns a newly created restaurant as @restaurant' do
          post :create, :restaurant => valid_attributes
          assigns(:restaurant).should be_a(Restaurant)
          assigns(:restaurant).should be_persisted
        end

        it 'redirects to the created restaurant' do
          post :create, :restaurant => valid_attributes
          response.should redirect_to(Restaurant.last)
        end
      end

      describe 'with invalid params' do
        it 'assigns a newly created but unsaved restaurant as @restaurant' do
          # Trigger the behavior that occurs when invalid params are submitted
          Restaurant.any_instance.stub(:save).and_return(false)
          post :create, :restaurant => {}
          assigns(:restaurant).should be_a_new(Restaurant)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Restaurant.any_instance.stub(:save).and_return(false)
          post :create, :restaurant => {}
          response.should render_template('new')
        end
      end
    end

    describe 'PUT update' do
      describe 'with valid params' do
        it 'updates the requested restaurant' do
          restaurant = Restaurant.create! valid_attributes
          # Assuming there are no other restaurants in the database, this
          # specifies that the Restaurant created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Restaurant.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => restaurant.id, :restaurant => {'these' => 'params'}
        end

        it 'assigns the requested restaurant as @restaurant' do
          restaurant = Restaurant.create! valid_attributes
          put :update, :id => restaurant.id, :restaurant => valid_attributes
          assigns(:restaurant).should eq(restaurant)
        end

        it 'redirects to the restaurant' do
          restaurant = Restaurant.create! valid_attributes
          put :update, :id => restaurant.id, :restaurant => valid_attributes
          response.should redirect_to(restaurant)
        end
      end

      describe 'with invalid params' do
        it 'assigns the restaurant as @restaurant' do
          restaurant = Restaurant.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Restaurant.any_instance.stub(:save).and_return(false)
          put :update, :id => restaurant.id.to_s, :restaurant => {}
          assigns(:restaurant).should eq(restaurant)
        end

        it "re-renders the 'edit' template" do
          restaurant = Restaurant.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Restaurant.any_instance.stub(:save).and_return(false)
          put :update, :id => restaurant.id.to_s, :restaurant => {}
          response.should render_template('edit')
        end
      end
    end

    describe 'DELETE destroy' do
      it 'destroys the requested restaurant' do
        restaurant = Restaurant.create! valid_attributes
        expect {
          delete :destroy, :id => restaurant.id.to_s
        }.to change(Restaurant, :count).by(-1)
      end

      it 'redirects to the restaurants list' do
        restaurant = Restaurant.create! valid_attributes
        delete :destroy, :id => restaurant.id.to_s
        response.should redirect_to(restaurants_url)
      end
    end
  end
end
