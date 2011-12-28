require 'spec_helper'

describe Restaurant::Comment do
  it { should validate_presence_of(:restaurant_id, :user_id) }
  it { should validate_length_of :text, within: 2..140 }
end
