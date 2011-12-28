class Restaurant::Menu::ItemsController < ApplicationController
  load_and_authorize_resource(class: 'Restaurant::Menu::Item')

  # GET /restaurant_menu_items
  # GET /menu_items.json
  def index
    @restaurant_menu_items = Restaurant::Menu::Item.paginate(page: params[:page])

    respond_to do |format|
      format.html # index.html.haml
      format.json # index.json.rabl
    end
  end

  # GET /restaurant_menu_items/1
  # GET /menu_items/1.json
  def show
    @restaurant_menu_item = Restaurant::Menu::Item.find(params[:id])
    @picture = Picture.new {|p| p.restaurant_id = @restaurant_menu_item.restaurant_id; p.menu_item_id = @restaurant_menu_item.id}
    @pictures = @restaurant_menu_item.pictures
    @restaurant_menu_item_comment = Restaurant::Menu::Item::Comment.new(restaurant_menu_item_id: @restaurant_menu_item.id)

    respond_to do |format|
      format.html # show.html.haml
      format.json # show.json.rabl
    end
  end

  # GET /restaurant_menu_items/new
  # GET /menu_items/new.json
  def new
    @restaurant_menu_item = Restaurant::Menu::Item.new

    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @restaurant_menu_item }
    end
  end

  # GET /restaurant_menu_items/1/edit
  def edit
    @restaurant_menu_item = Restaurant::Menu::Item.find(params[:id])
  end

  # POST /restaurant_menu_items
  # POST /menu_items.json
  def create
    @restaurant_menu_item = Restaurant::Menu::Item.new(params[:restaurant_menu_item])

    respond_to do |format|
      if @restaurant_menu_item.save
        format.html { redirect_to @restaurant_menu_item, notice: 'Item was successfully created.' }
        format.json { render json: @restaurant_menu_item, status: :created, location: @restaurant_menu_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @restaurant_menu_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /restaurant_menu_items/1
  # PUT /menu_items/1.json
  def update
    @restaurant_menu_item = Restaurant::Menu::Item.find(params[:id])

    respond_to do |format|
      if @restaurant_menu_item.update_attributes(params[:restaurant_menu_item])
        format.html { redirect_to @restaurant_menu_item, notice: 'Item was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @restaurant_menu_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurant_menu_items/1
  # DELETE /menu_items/1.json
  def destroy
    @restaurant_menu_item = Restaurant::Menu::Item.find(params[:id])
    @restaurant_menu_item.destroy

    respond_to do |format|
      format.html { redirect_to restaurant_menu_items_url }
      format.json { head :ok }
    end
  end
end
