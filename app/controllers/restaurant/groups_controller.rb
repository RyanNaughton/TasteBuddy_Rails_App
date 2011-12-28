class Restaurant::GroupsController < ApplicationController
  load_and_authorize_resource(class: 'Restaurant::Group')

  # GET /restaurant/groups
  # GET /restaurant/groups.json
  def index
    @restaurant_groups = Restaurant::Group.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @restaurant_groups }
    end
  end

  # GET /restaurant/groups/1
  # GET /restaurant/groups/1.json
  def show
    @restaurant_group = Restaurant::Group
      .includes(:boss_restaurant)
      .includes(:restaurants)
      .find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @restaurant_group }
    end
  end

  # GET /restaurant/groups/new
  # GET /restaurant/groups/new.json
  def new
    @restaurant_group = Restaurant::Group.new
    @valid_boss_restaurants = Restaurant::Group.valid_boss_restaurants

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @restaurant_group }
    end
  end

  # GET /restaurant/groups/1/edit
  def edit
    @restaurant_group = Restaurant::Group.find(params[:id])
  end

  # POST /restaurant/groups
  # POST /restaurant/groups.json
  def create
    @restaurant_group = Restaurant::Group.new(params[:restaurant_group])

    respond_to do |format|
      if @restaurant_group.save
        format.html { redirect_to @restaurant_group, notice: 'Group was successfully created.' }
        format.json { render json: @restaurant_group, status: :created, location: @restaurant_group }
      else
        format.html { render action: 'new' }
        format.json { render json: @restaurant_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /restaurant/groups/1
  # PUT /restaurant/groups/1.json
  def update
    @restaurant_group = Restaurant::Group.find(params[:id])

    respond_to do |format|
      if @restaurant_group.update_attributes(params[:restaurant_group])
        format.html { redirect_to @restaurant_group, notice: 'Group was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @restaurant_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurant/groups/1
  # DELETE /restaurant/groups/1.json
  def destroy
    @restaurant_group = Restaurant::Group.find(params[:id])
    @restaurant_group.destroy

    respond_to do |format|
      format.html { redirect_to restaurant_groups_url }
      format.json { head :ok }
    end
  end
end
