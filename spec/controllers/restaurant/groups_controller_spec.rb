require 'spec_helper'

describe Restaurant::GroupsController do
  context 'when the user is an admin' do
    before(:each) do
      sign_in Factory(:admin)
      @boss_restaurant = Factory(:restaurant)
    end

    def valid_attributes
      {name: 'Pidgin Restaurants', boss_restaurant_id: @boss_restaurant.id}
    end

    describe 'GET index' do
      it 'assigns all restaurant_groups as @restaurant_groups' do
        group = Restaurant::Group.create! valid_attributes
        get :index
        assigns(:restaurant_groups).should eq([group])
      end
    end

    describe 'GET show' do
      it 'assigns the requested group as @restaurant_group' do
        group = Restaurant::Group.create! valid_attributes
        get :show, :id => group.id.to_s
        assigns(:restaurant_group).should eq(group)
      end

      it 'applies an ActiveRecord relation scope to include boss restaurant' do
        group = Restaurant::Group.create! valid_attributes
        chain = Restaurant::Group.scoped
        chain.should_receive(:includes).with(:boss_restaurant).and_return(chain.includes(:boss_restaurant))
        chain.should_receive(:includes).with(:restaurant).and_return(chain.includes(:restaurant))
        get :show, :id => group.id.to_s
      end
    end

    describe 'GET new' do
      it 'assigns a new group as @group' do
        Restaurant::Group.should_receive(:valid_boss_restaurants).and_return([@boss_restaurant])
        get :new
        assigns(:restaurant_group).should be_a_new(Restaurant::Group)
      end
    end

    describe 'GET edit' do
      it 'assigns the requested group as @group' do
        group = Restaurant::Group.create! valid_attributes
        get :edit, :id => group.id.to_s
        assigns(:restaurant_group).should eq(group)
      end
    end

    describe 'POST create' do
      describe 'with valid params' do
        it 'creates a new Restaurant::Group' do
          expect {
            post :create, :restaurant_group => valid_attributes
          }.to change(Restaurant::Group, :count).by(1)
        end

        it 'assigns a newly created group as @group' do
          post :create, :restaurant_group => valid_attributes
          assigns(:restaurant_group).should be_a(Restaurant::Group)
          assigns(:restaurant_group).should be_persisted
        end

        it 'redirects to the created group' do
          post :create, :restaurant_group => valid_attributes
          response.should redirect_to(Restaurant::Group.last)
        end
      end

      describe 'with invalid params' do
        it 'assigns a newly created but unsaved group as @group' do
          # Trigger the behavior that occurs when invalid params are submitted
          Restaurant::Group.any_instance.stub(:save).and_return(false)
          post :create, :restaurant_group => {}
          assigns(:restaurant_group).should be_a_new(Restaurant::Group)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Restaurant::Group.any_instance.stub(:save).and_return(false)
          post :create, :group => {}
          response.should render_template('new')
        end
      end
    end

    describe 'PUT update' do
      describe 'with valid params' do
        it 'updates the requested group' do
          group = Restaurant::Group.create! valid_attributes
          # Assuming there are no other restaurant_groups in the database, this
          # specifies that the Restaurant::Group created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Restaurant::Group.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => group.id, :restaurant_group => {'these' => 'params'}
        end

        it 'assigns the requested group as @group' do
          group = Restaurant::Group.create! valid_attributes
          put :update, :id => group.id, :restaurant_group => valid_attributes
          assigns(:restaurant_group).should eq(group)
        end

        it 'redirects to the group' do
          group = Restaurant::Group.create! valid_attributes
          put :update, :id => group.id, :restaurant_group => valid_attributes
          response.should redirect_to(group)
        end
      end

      describe 'with invalid params' do
        it 'assigns the group as @group' do
          group = Restaurant::Group.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Restaurant::Group.any_instance.stub(:save).and_return(false)
          put :update, :id => group.id.to_s, :restaurant_group => {}
          assigns(:restaurant_group).should eq(group)
        end

        it "re-renders the 'edit' template" do
          group = Restaurant::Group.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Restaurant::Group.any_instance.stub(:save).and_return(false)
          put :update, :id => group.id.to_s, :restaurant_group => {}
          response.should render_template('edit')
        end
      end
    end

    describe 'DELETE destroy' do
      it 'destroys the requested group' do
        group = Restaurant::Group.create! valid_attributes
        expect {
          delete :destroy, :id => group.id.to_s
        }.to change(Restaurant::Group, :count).by(-1)
      end

      it 'redirects to the restaurant_groups list' do
        group = Restaurant::Group.create! valid_attributes
        delete :destroy, :id => group.id.to_s
        response.should redirect_to(restaurant_groups_url)
      end
    end
  end
end
