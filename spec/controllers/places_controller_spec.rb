require 'rails_helper'

RSpec.describe PlacesController, type: :controller do
  let!(:place) { FactoryBot.create(:place) }
  let!(:rating) { FactoryBot.build(:rating, place_id: place.id) }

  before { rating.save! }
  
  describe '#index' do
    it 'assigns @places' do
      get :index

      expect(response).to have_http_status(:ok)
      expect(assigns(:places)).to match_array([place])
    end
  end

  describe '#index with valid search params' do
    it 'assigns @places' do
      get :index, :params => { :search => "chi", :page => 1 }

      expect(response).to have_http_status(:ok)
      expect(assigns(:places)).to match_array([place])
    end
  end

  describe '#index with invalid search params' do
    before { rating.save! }
    
    it 'assigns @places' do
      get :index, :params => { :search => "invalid search", :page => 1 }

      expect(response).to have_http_status(:ok)
      expect(assigns(:places)).to match_array([])
    end
  end
end