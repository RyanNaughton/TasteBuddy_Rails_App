require 'spec_helper'

describe HomeController do
  describe 'GET index' do
    it 'does not raise error' do
      proc { get :index }.should_not raise_error
    end
  end
end
