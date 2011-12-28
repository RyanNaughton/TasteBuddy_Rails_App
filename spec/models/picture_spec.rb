require 'spec_helper'

describe Picture do
  it 'validates' do
    Factory.build(:picture).should be_valid
  end
end
