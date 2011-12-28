require 'spec_helper'

describe "Restaurant::Menu::Items" do
  describe "GET /restaurant_menu_items" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get restaurant_menu_items_path
      response.status.should be(200)
    end
  end
end
