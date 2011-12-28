require 'spec_helper'

describe Restaurant::Menu::Item::Bookmark do
  it { should validate_presence_of(:user_id, :restaurant_menu_item_id) }
end
