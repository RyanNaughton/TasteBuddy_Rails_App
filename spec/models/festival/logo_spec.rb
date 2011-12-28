require 'spec_helper'

describe Festival::Logo do
  it {
    Factory(:festival_logo, festival: Factory(:festival))
    should validate_uniqueness_of(:festival_id)
  }
  it { should validate_presence_of(:standard_resolution, :low_resolution) }
end
