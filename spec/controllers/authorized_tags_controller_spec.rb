require 'spec_helper'

describe AuthorizedTagsController do

  def valid_attributes
    {name: 'bitter'}
  end

  describe 'GET tag_names' do
    it 'assigns all authorized_tags as @authorized_tags' do
      authorized_tag = AuthorizedTag.create! valid_attributes
      get :tag_names
      assigns(:authorized_tags).should eq([authorized_tag])
    end
  end

end
