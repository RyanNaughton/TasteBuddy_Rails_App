require 'spec_helper'

describe Restaurant::CommentsController do

  def valid_attributes
    {}
  end

  describe "POST create" do

    describe "with valid params" do
      it "creates a new Restaurant::Comment" do
        pending()
        expect {
          post :create, :comment => valid_attributes
        }.to change(Restaurant::Comment, :count).by(1)
      end

      it "assigns a newly created comment as @comment" do
        pending()
        post :create, :comment => valid_attributes
        assigns(:comment).should be_a(Restaurant::Comment)
        assigns(:comment).should be_persisted
      end

      it "redirects to the created comment" do
        pending()
        post :create, :comment => valid_attributes
        response.should redirect_to(Restaurant::Comment.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved comment as @comment" do
        pending()
        # Trigger the behavior that occurs when invalid params are submitted
        Restaurant::Comment.any_instance.stub(:save).and_return(false)
        post :create, :comment => {}
        assigns(:comment).should be_a_new(Restaurant::Comment)
      end

      it "re-renders the 'new' template" do
        pending()
        # Trigger the behavior that occurs when invalid params are submitted
        Restaurant::Comment.any_instance.stub(:save).and_return(false)
        post :create, :comment => {}
        response.should render_template("new")
      end
    end
  end

end
