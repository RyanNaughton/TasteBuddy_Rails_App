class Restaurant::MenusController < ApplicationController
  # GET /restaurants/1/menu
  def show
    @restaurant = Restaurant
      .includes(menu: {restaurant_menu_items: {comments: [:user], pictures: [:user]}})
      .find(params[:id])
    @restaurant_menu = @restaurant.menu
    @data = @restaurant_menu
      .restaurant_menu_items
      .group_by(&:section)
      .map {|k,v| {name: k, subsections: v.group_by(&:subsection).map {|kk, vv| {name: kk, menu_items: vv}}}}
    puts @data.inspect

    respond_to do |format|
      format.html # show.html.haml
      format.json # show.html.rabl
    end
  end

  # GET /restaurants/1/menus/grubhub
  def grubhub
    @restaurant = Restaurant.find(params[:id])
    @menu_csv = @restaurant.grubhub_menu_csv

    respond_to do |format|
      format.csv { render text: @menu_csv }
    end
  end

  # GET /restaurants/1/menus/menupages
  def menupages
    @restaurant = Restaurant.find(params[:id])
    @menu_csv = @restaurant.menupages_menu_csv

    respond_to do |format|
      format.csv { render text: @menu_csv }
    end
  end
end
