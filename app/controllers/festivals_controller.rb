class FestivalsController < ApplicationController
  load_and_authorize_resource

  # GET /festivals
  # GET /festivals.json
  def index
    @coordinates = [params[:latitude], params[:longitude]]
    @festivals = Festival.all

    respond_to do |format|
      format.html # index.html.haml
      format.json
    end
  end

  # GET /festivals/1
  # GET /festivals/1.json
  def show
    @festival = Festival.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @festival }
    end
  end

  # GET /festivals/new
  # GET /festivals/new.json
  def new
    @festival = Festival.new

    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @festival }
    end
  end

  # GET /festivals/1/edit
  def edit
    @festival = Festival.find(params[:id])
  end

  # POST /festivals
  # POST /festivals.json
  def create
    @festival = Festival.new(params[:festival])

    respond_to do |format|
      if @festival.save
        format.html { redirect_to @festival, notice: 'Festival was successfully created.' }
        format.json { render json: @festival, status: :created, location: @festival }
      else
        format.html { render action: 'new' }
        format.json { render json: @festival.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /festivals/1
  # PUT /festivals/1.json
  def update
    @festival = Festival.find(params[:id])

    respond_to do |format|
      if @festival.update_attributes(params[:festival])
        format.html { redirect_to @festival, notice: 'Festival was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @festival.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /festivals/1
  # DELETE /festivals/1.json
  def destroy
    @festival = Festival.find(params[:id])
    @festival.destroy

    respond_to do |format|
      format.html { redirect_to festivals_url }
      format.json { head :ok }
    end
  end
end
