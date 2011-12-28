require 'spec_helper'

describe Restaurant::Menupages do
  before(:each) do
    @restaurant = Factory(:chicago_joes)
  end

  describe '#menupages_menu_csv' do
    it 'converts menupages menu data to csv' do
      @restaurant.should_receive(:menupages_menu).and_return(yaml_fixture('chicago_joes_menupages_menu.yaml'))
      @restaurant.menupages_menu_csv.should eq fixture('chicago_joes_menupages_menu.csv').read
    end
  end

  describe '#menupages_menu' do
    it 'raises an error if no menupages_url is present' do
      @restaurant.menupages_url = nil
      proc { @restaurant.menupages_menu }.should raise_error ArgumentError, 'menupages_url required'
    end
  end
end
