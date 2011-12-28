require 'spec_helper'

describe Restaurant::Grubhub do
  before(:each) do
    @restaurant = Factory(:chicago_joes)
  end

  describe '#grubhub_menu_csv' do
    it 'converts grubhub menu data to csv' do
      @restaurant.should_receive(:grubhub_menu).and_return(yaml_fixture('chicago_joes_grubhub_menu.yaml'))
      @restaurant.grubhub_menu_csv.should eq fixture('chicago_joes_grubhub_menu.csv').read
    end
  end

  describe '#grubhub_menu' do
    it 'raises an error if no grubhub_url is present' do
      @restaurant.grubhub_url = nil
      proc { @restaurant.grubhub_menu }.should raise_error ArgumentError, 'grubhub_url required'
    end
  end
end
