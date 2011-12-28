require 'spec_helper'

describe Restaurant::Rating do
  it { should validate_presence_of(:value, :restaurant_id, :user_id) }
end
