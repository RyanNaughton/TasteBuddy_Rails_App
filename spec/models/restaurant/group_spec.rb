require 'spec_helper'

describe Restaurant::Group do
  context 'validations' do
    it { should validate_presence_of(:name, :boss_restaurant_id) }
    it { should validate_associated(:boss_restaurant) }
  end

  context 'associations' do
    it 'takes the name of the associated boss_restaurant if name is blank' do
      @group = Factory(:restaurant_group, name: '')
      @group.name.should eq @group.boss_restaurant.name
    end

    context 'creation and destruction' do
      before(:each) do
        @group = Factory(:restaurant_group)
        @boss_restaurant = @group.boss_restaurant
      end

      describe '#after_create' do
        it 'calls #set_group_id_in_associated_boss_restaurant' do
          @boss_restaurant.restaurant_group_id.should eq @group.id
        end
      end

      describe '#after_destroy' do
        it 'calls #reset_group_id_in_associated_boss_restaurant' do
          @group.destroy
          @boss_restaurant.restaurant_group_id.should be_nil
        end
      end
    end
  end
end
