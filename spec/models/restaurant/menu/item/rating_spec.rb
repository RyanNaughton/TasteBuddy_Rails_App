require 'spec_helper'

describe Restaurant::Menu::Item::Rating do
  it { should validate_presence_of(:value, :restaurant_menu_item_id, :user_id) }
end
