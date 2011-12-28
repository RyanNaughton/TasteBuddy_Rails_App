require 'spec_helper'

describe 'Restaurant::Comments' do
  describe 'POST /restaurants/1/comment' do
    it 'works' do
      pending()
      post restaurant_comments_path
      response.status.should be(200)
    end
  end
end
