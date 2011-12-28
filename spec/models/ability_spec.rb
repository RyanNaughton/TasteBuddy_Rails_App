require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  describe 'as guest' do
    before(:each) do
      @ability = Ability.new(nil)
    end

    it 'can read all' do
      @ability.should be_able_to(:read, :all)
    end

    context 'comments' do
      it 'cannot create' do
        @ability.should_not be_able_to(:create, Restaurant::Comment)
        @ability.should_not be_able_to(:create, Restaurant::Menu::Item::Comment)
      end
    end

    it 'cannot create pictures' do
      @ability.should_not be_able_to(:create, :pictures)
    end

    it 'can only view restaurants' do
      @ability.should be_able_to(:read, :restaurants)
      @ability.should_not be_able_to(:create, :users)
      @ability.should_not be_able_to(:update, :restaurants)
      @ability.should_not be_able_to(:destroy, :restaurants)
    end
  end

  describe 'as persisted user' do
    before(:each) do
      @user = Factory(:user)
      @ability = Ability.new(@user)
    end

    context 'comments' do
      it 'can create' do
        @ability.should be_able_to(:create, Restaurant::Comment)
        @ability.should be_able_to(:create, Restaurant::Menu::Item::Comment)
      end
    end

    context 'pictures' do
      it 'can create' do
        @ability.should be_able_to(:create, :pictures)
      end

      it 'can manage own' do
        picture = Factory(:picture, user: @user)
        @ability.should be_able_to(:manage, picture)
      end
    end
  end

  describe 'as admin' do
    before(:each) do
      admin = Factory(:admin)
      @ability = Ability.new(admin)
    end

    it 'can manage all' do
      @ability.should be_able_to(:manage, :all)
    end
  end
end
