require 'spec_helper'

describe Festival do
  it { should validate_presence_of(:name) }

  describe '#as_json' do
    before(:each) do
      @festival = Factory(:taste_of_chicago)
      header_color = Factory(:festival_header_color, festival_id: @festival.id)
      logo = Factory(:festival_logo, festival_id: @festival.id)
    end

    it 'matches the expected value' do
      as_json = HashWithIndifferentAccess.new(@festival.as_json.merge(id: nil))
      as_json[:header_color].merge!(id: nil, festival_id: nil)
      as_json[:logo].merge!(id: nil, festival_id: nil)
      JSON.load(as_json.to_json).should eq json_fixture('festival_to_json.json')
    end
  end
end
