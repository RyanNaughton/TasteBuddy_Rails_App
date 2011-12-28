require 'spec_helper'

describe Restaurant::Menu::Item::Tag do
  it { should validate_presence_of(:restaurant_menu_item_id, :authorized_tag_id, :user_id) }
end
