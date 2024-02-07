require 'rails_helper'

RSpec.describe Rating, type: :model do
  let!(:place) { FactoryBot.create(:place) }
  let!(:rating) { FactoryBot.build(:rating, place_id: place.id) }
  let!(:invalid_rating) { FactoryBot.build(:rating, place_id: place.id, value: "bad value") }
  
  describe "rating model validations" do
    it "should save successfully" do
      expect(rating.save).to eq(true)
    end

    it "shouldn't save successfully" do
      expect(invalid_rating.save).to eq(false)
    end

    before { rating.save! }
    
    it "validates a place exists and value is numeric" do

      expect(rating.place_id).to eq(place.id)
      expect(rating.value).to be_a_kind_of(Numeric)
    end
  end
end
