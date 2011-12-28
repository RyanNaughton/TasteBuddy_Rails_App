require 'spec_helper'

describe Restaurant::Tag do
  it { should validate_presence_of(:restaurant_id, :authorized_tag_id, :user_id) }
end
