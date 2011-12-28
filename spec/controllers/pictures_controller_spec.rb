require 'spec_helper'

describe PicturesController do
  context 'when the user is an admin' do
    before do
      @admin = Factory(:admin)
      sign_in @admin
    end

    def valid_attributes
      {user_id: @admin.id}
    end

    describe 'GET index' do
      it 'assigns all pictures as @pictures' do
        picture = Picture.create! valid_attributes
        get :index
        assigns(:pictures).should eq([picture])
      end
    end

    describe 'GET show' do
      it 'assigns the requested picture as @picture' do
        picture = Picture.create! valid_attributes
        get :show, :id => picture.id.to_s
        assigns(:picture).should eq(picture)
      end
    end

    describe 'GET new' do
      it 'assigns a new picture as @picture' do
        get :new
        assigns(:picture).should be_a_new(Picture)
      end
    end

    describe 'GET edit' do
      it 'assigns the requested picture as @picture' do
        picture = Picture.create! valid_attributes
        get :edit, :id => picture.id.to_s
        assigns(:picture).should eq(picture)
      end
    end

    describe 'POST create' do
      describe 'with valid params' do
        it 'creates a new Picture' do
          expect {
            post :create, :picture => valid_attributes
          }.to change(Picture, :count).by(1)
        end

        it 'assigns a newly created picture as @picture' do
          post :create, :picture => valid_attributes
          assigns(:picture).should be_a(Picture)
          assigns(:picture).should be_persisted
        end

        it 'redirects to the created picture' do
          post :create, :picture => valid_attributes
          response.should redirect_to(Picture.last)
        end
      end

      describe 'with invalid params' do
        it 'assigns a newly created but unsaved picture as @picture' do
          # Trigger the behavior that occurs when invalid params are submitted
          Picture.any_instance.stub(:save).and_return(false)
          post :create, :picture => {}
          assigns(:picture).should be_a_new(Picture)
        end

        it 're-renders the "new" template' do
          # Trigger the behavior that occurs when invalid params are submitted
          Picture.any_instance.stub(:save).and_return(false)
          post :create, :picture => {}
          response.should render_template('new')
        end
      end
    end

    describe 'PUT update' do
      describe 'with valid params' do
        it 'updates the requested picture' do
          picture = Picture.create! valid_attributes
          # Assuming there are no other pictures in the database, this
          # specifies that the Picture created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Picture.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => picture.id, :picture => {'these' => 'params'}
        end

        it 'assigns the requested picture as @picture' do
          picture = Picture.create! valid_attributes
          put :update, :id => picture.id, :picture => valid_attributes
          assigns(:picture).should eq(picture)
        end

        it 'redirects to the picture' do
          picture = Picture.create! valid_attributes
          put :update, :id => picture.id, :picture => valid_attributes
          response.should redirect_to(picture)
        end
      end

      describe 'with invalid params' do
        it 'assigns the picture as @picture' do
          picture = Picture.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Picture.any_instance.stub(:save).and_return(false)
          put :update, :id => picture.id.to_s, :picture => {}
          assigns(:picture).should eq(picture)
        end

        it 're-renders the "edit" template' do
          picture = Picture.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Picture.any_instance.stub(:save).and_return(false)
          put :update, :id => picture.id.to_s, :picture => {}
          response.should render_template('edit')
        end
      end
    end

    describe 'DELETE destroy' do
      it 'destroys the requested picture' do
        picture = Picture.create! valid_attributes
        expect {
          delete :destroy, :id => picture.id.to_s
        }.to change(Picture, :count).by(-1)
      end

      it 'redirects to the pictures list' do
        picture = Picture.create! valid_attributes
        delete :destroy, :id => picture.id.to_s
        response.should redirect_to(pictures_url)
      end
    end
  end
end
