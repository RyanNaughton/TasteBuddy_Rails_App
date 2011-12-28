require 'spec_helper'

describe Restaurant::Menu::Item::Comment do
  it { should validate_presence_of(:restaurant_menu_item_id, :user_id) }
  it { should validate_length_of(:text, within: 2..140) }
end
