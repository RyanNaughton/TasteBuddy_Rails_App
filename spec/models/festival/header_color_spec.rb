require 'spec_helper'

describe Festival::HeaderColor do
  it {
    Factory(:festival_header_color, festival: Factory(:festival))
    should validate_uniqueness_of(:festival_id)
  }
  it { should validate_presence_of(:red, :green, :blue) }
end
