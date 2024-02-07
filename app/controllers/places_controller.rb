class PlacesController < ApplicationController
  before_action :set_place, only: %i[ show edit update destroy ]

  # Default to page 1
  DEFAULT_PAGE = 1

  # GET /places or /places.json
  def index
    # Check for page param otherwise use default
    page = params[:page] ? params[:page] : DEFAULT_PAGE

    @places = if params[:search]
      begin
        # Sanitize and normalize search query
        query = sanitize_and_normalize(params[:search])

        search_places(query, page)
      rescue => e
        Rails.logger.error "Error searching for places: #{e.message}"
      end
    else
      begin
        # Grouping & ordering is more efficient than sort_by
        Place.joins(:ratings)
        .group('places.id')
        .order('AVG(ratings.value) DESC')
        .page(page)
        .each do |place|
          begin
            # Set average rating
            place.average_rating = place.rating
          rescue => e
            Rails.logger.error "Error setting average rating #{place.id}: #{e.message}"
          end
        end
      rescue => e
        Rails.logger.error "Error retrieving places: #{e.message}"
      end
    end
    
    if @places
      render json: @places
    else
      render json: []
    end
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

    # Remove leading/trailing whitespace / upcase characters / sanitize LIKE query
    def sanitize_and_normalize(query)
      begin
        ActiveRecord::Base::sanitize_sql_like(query.strip.upcase)
      rescue => e
        Rails.logger.error "Error sanitizing search query: #{e.message}"
      end
    end

    def search_places(query, page)
      # Grouping & ordering is more efficient than sort_by
      Place.joins(:ratings)
      .group('places.id')
      .order('AVG(ratings.value) DESC')
      .where("name LIKE ? OR description LIKE ?", "%#{query}%","%#{query}%")
      .page(page)
      .each do |place|
        begin
          # set average rating
          place.average_rating = place.rating
        rescue => e
          Rails.logger.error "Error setting average rating #{place.id}: #{e.message}"
        end
      end
    end
end
