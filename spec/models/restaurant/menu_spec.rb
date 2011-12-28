require 'spec_helper'

describe Restaurant::Menu do
  it { should validate_presence_of(:restaurant_id) }
end
