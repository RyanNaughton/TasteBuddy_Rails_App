require 'spec_helper'

describe 'AuthorizedTags' do
  describe 'GET /tags' do
    it 'works' do
      @tag = Factory(:authorized_tag, name: 'bubbly')
      get authorized_tag_names_path, format: 'json'
      response.status.should be(200)
      response.body.should eq '["bubbly"]'
    end
  end
end
