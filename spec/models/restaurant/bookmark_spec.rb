require 'spec_helper'

describe Restaurant::Bookmark do
  it { should validate_presence_of(:user_id, :restaurant_id) }
end
