require 'spec_helper'

describe Restaurant::MenusController do
  context 'when the user is an admin' do
    before(:each) do
      sign_in Factory(:admin)
      @restaurant = Factory(:chicago_joes)
    end

    describe 'GET show' do
      before(:each) do
        Restaurant.any_instance.stub(:menu).and_return('menu')
      end

      it 'assigns the requested restaurant as @restaurant' do
        pending()
        get :show, :id => @restaurant.id.to_s
        assigns(:restaurant).should eq(@restaurant)
      end

      it 'assigns the menu as @restaurant_menu' do
        pending()
        get :show, :id => @restaurant.id.to_s
        assigns(:restaurant_menu).should eq('menu')
      end
    end

    describe 'GET grubhub' do
      before(:each) do
        Restaurant.any_instance.stub(:grubhub_menu_csv).and_return('csv_data')
      end

      it 'assigns the requested restaurant as @restaurant' do
        get :grubhub, :id => @restaurant.id.to_s
        assigns(:restaurant).should eq(@restaurant)
      end

      it 'assigns the menu csv as @menu_csv' do
        get :grubhub, :id => @restaurant.id.to_s
        assigns(:menu_csv).should eq('csv_data')
      end

      it 'calls the grubhub_menu_csv method on @restaurant' do
        Restaurant.any_instance.should_receive(:grubhub_menu_csv)
        get :grubhub, :id => @restaurant.id.to_s
      end
    end

    describe 'GET menupages' do
      before(:each) do
        Restaurant.any_instance.stub(:menupages_menu_csv).and_return('csv_data')
      end

      it 'assigns the requested restaurant as @restaurant' do
        get :menupages, :id => @restaurant.id.to_s
        assigns(:restaurant).should eq(@restaurant)
      end

      it 'assigns the menu csv as @menu_csv' do
        get :menupages, :id => @restaurant.id.to_s
        assigns(:menu_csv).should eq('csv_data')
      end

      it 'calls the menupages_menu_csv method on @restaurant' do
        Restaurant.any_instance.should_receive(:menupages_menu_csv)
        get :menupages, :id => @restaurant.id.to_s
      end
    end
  end
end
