require 'spec_helper'

describe User do
  it {
    Factory(:user)
    should validate_uniqueness_of(:username, :email, case_sensitive: false)
  }
  it { should validate_inclusion_of :gender, in: %w{m f}, allow_blank: true }
  it { should validate_inclusion_of :country, in: User::COUNTRIES, allow_blank: true }

  context 'auth token' do
    it 'is generated on create' do
      Factory(:user).authentication_token.should be_present
    end
  end
end
