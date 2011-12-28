require 'spec_helper'

describe AuthorizedTagsController do
  describe 'routing' do

    it 'routes to #tag_names' do
      get('/tags').should route_to('authorized_tags#tag_names')
    end

  end
end
