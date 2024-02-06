class PlacesController < ApplicationController
  before_action :set_place, only: %i[ show edit update destroy ]

  # Default to page 1
  DEFAULT_PAGE = 1

  # GET /places or /places.json
  def index
    @places = if params[:search]
      search = sanitize_and_normalize(params[:search])
      page = params[:page] ? params[:page] : DEFAULT_PAGE

      # TODO: Make more efficient. This will slow down when the DB has a lot of records
      Place.where("name LIKE ? OR description LIKE ?", "%#{search}%","%#{search}%").page(page).sort_by(&:rating).reverse
    else
      Place.all
    end
    
    render json: @places
  end

  # GET /places/1 or /places/1.json
  def show
    render json: @place
  end

  # GET /places/new
  def new
    @place = Place.new
  end

  # GET /places/1/edit
  def edit
  end

  # POST /places or /places.json
  def create
    @place = Place.new(place_params)

    respond_to do |format|
      if @place.save
        format.html { redirect_to place_url(@place), notice: "Place was successfully created." }
        format.json { render :show, status: :created, location: @place }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /places/1 or /places/1.json
  def update
    respond_to do |format|
      if @place.update(place_params)
        format.html { redirect_to place_url(@place), notice: "Place was successfully updated." }
        format.json { render :show, status: :ok, location: @place }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1 or /places/1.json
  def destroy
    @place.destroy!

    respond_to do |format|
      format.html { redirect_to places_url, notice: "Place was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def place_params
      params.require(:place).permit(:latitude, :longitude, :name, :description)
    end

    # Remove leading/trailing whitespace / upcase characters / sanitize like query
    def sanitize_and_normalize(string)
      ActiveRecord::Base::sanitize_sql_like(string.strip.upcase)
    end
end
