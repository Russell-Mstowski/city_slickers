require 'rails_helper'
require 'json'

RSpec.describe PlacesController, type: :controller do
  let!(:places) { [ FactoryBot.create(:place), FactoryBot.create(:place) ] }

  before do
    places.each do |pl|
      5.times do
        rating = FactoryBot.build(:rating, place_id: pl.id)
        rating.save
      end
    end
  end
  
  describe '#index' do
    it 'assigns @places' do
      get :index

      expect(response).to have_http_status(:ok)
      expect(assigns(:places)).to match_array(places)
    end

    it 'sorts places by average rating' do
      get :index

      data = JSON.parse(response.body)
      expect(data.first["average_rating"]).to be > data.second["average_rating"]
    end
  end

  describe '#index with valid search params' do
    it 'assigns @places' do
      get :index, :params => { :search => "chi", :page => 1 }

      data = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(assigns(:places)).to match_array(places)
      expect(data.first["average_rating"]).to be > data.second["average_rating"]
    end
  end

  describe '#index with invalid search params' do
    it 'assigns @places and return empty' do
      get :index, :params => { :search => "invalid search", :page => 1 }

      expect(response).to have_http_status(:ok)
      expect(assigns(:places)).to match_array([])
    end
  end
end