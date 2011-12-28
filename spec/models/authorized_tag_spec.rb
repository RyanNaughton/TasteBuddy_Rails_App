require 'spec_helper'

describe AuthorizedTag do
  it { should validate_presence_of(:name) }
end
