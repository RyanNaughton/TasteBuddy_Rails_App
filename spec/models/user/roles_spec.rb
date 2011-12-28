require 'spec_helper'

describe User::Roles do
  context 'roles' do
    describe '#add_role' do
      before do
        @user = Factory(:user)
      end

      it 'adds a role' do
        @user.add_role(:admin)
        @user.roles.should include(:admin)
      end
    end

    describe '#admin?' do
      before do
        @user = Factory(:admin)
      end

      it 'checks for admin status' do
        @user.admin?.should be_true
      end
    end
  end
end
