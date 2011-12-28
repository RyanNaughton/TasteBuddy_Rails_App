require 'spec_helper'

describe FestivalsController do
  context 'when the user is an admin' do
    before(:each) do
      sign_in Factory(:admin)
    end

    def valid_attributes
      {name: 'name'}
    end

    describe 'GET index' do
      it 'assigns all festivals as @festivals' do
        festival = Festival.create! valid_attributes
        get :index
        assigns(:festivals).should eq([festival])
      end
    end

    describe 'GET show' do
      it 'assigns the requested festival as @festival' do
        festival = Festival.create! valid_attributes
        get :show, :id => festival.id.to_s
        assigns(:festival).should eq(festival)
      end
    end

    describe 'GET new' do
      it 'assigns a new festival as @festival' do
        get :new
        assigns(:festival).should be_a_new(Festival)
      end
    end

    describe 'GET edit' do
      it 'assigns the requested festival as @festival' do
        festival = Festival.create! valid_attributes
        get :edit, :id => festival.id.to_s
        assigns(:festival).should eq(festival)
      end
    end

    describe 'POST create' do
      describe 'with valid params' do
        it 'creates a new Festival' do
          expect {
            post :create, :festival => valid_attributes
          }.to change(Festival, :count).by(1)
        end

        it 'assigns a newly created festival as @festival' do
          post :create, :festival => valid_attributes
          assigns(:festival).should be_a(Festival)
          assigns(:festival).should be_persisted
        end

        it 'redirects to the created festival' do
          post :create, :festival => valid_attributes
          response.should redirect_to(Festival.last)
        end
      end

      describe 'with invalid params' do
        it 'assigns a newly created but unsaved festival as @festival' do
          # Trigger the behavior that occurs when invalid params are submitted
          Festival.any_instance.stub(:save).and_return(false)
          post :create, :festival => {}
          assigns(:festival).should be_a_new(Festival)
        end

        it 're-renders the "new" template' do
          # Trigger the behavior that occurs when invalid params are submitted
          Festival.any_instance.stub(:save).and_return(false)
          post :create, :festival => {}
          response.should render_template('new')
        end
      end
    end

    describe 'PUT update' do
      describe 'with valid params' do
        it 'updates the requested festival' do
          festival = Festival.create! valid_attributes
          # Assuming there are no other festivals in the database, this
          # specifies that the Festival created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Festival.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => festival.id, :festival => {'these' => 'params'}
        end

        it 'assigns the requested festival as @festival' do
          festival = Festival.create! valid_attributes
          put :update, :id => festival.id, :festival => valid_attributes
          assigns(:festival).should eq(festival)
        end

        it 'redirects to the festival' do
          festival = Festival.create! valid_attributes
          put :update, :id => festival.id, :festival => valid_attributes
          response.should redirect_to(festival)
        end
      end

      describe 'with invalid params' do
        it 'assigns the festival as @festival' do
          festival = Festival.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Festival.any_instance.stub(:save).and_return(false)
          put :update, :id => festival.id.to_s, :festival => {}
          assigns(:festival).should eq(festival)
        end

        it 're-renders the "edit" template' do
          festival = Festival.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Festival.any_instance.stub(:save).and_return(false)
          put :update, :id => festival.id.to_s, :festival => {}
          response.should render_template('edit')
        end
      end
    end

    describe 'DELETE destroy' do
      it 'destroys the requested festival' do
        festival = Festival.create! valid_attributes
        expect {
          delete :destroy, :id => festival.id.to_s
        }.to change(Festival, :count).by(-1)
      end

      it 'redirects to the festivals list' do
        festival = Festival.create! valid_attributes
        delete :destroy, :id => festival.id.to_s
        response.should redirect_to(festivals_url)
      end
    end
  end
end
