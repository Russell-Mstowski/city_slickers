require 'rails_helper'

RSpec.describe Place, type: :model do
  let!(:place) { FactoryBot.create(:place) }
  let!(:rating) { FactoryBot.build(:rating, place_id: place.id) }
  
  before { rating.save! }

  describe "place model methods" do
    it "returns the average rating of a place" do
      expect(place.rating).to eq(rating.value)
    end
  end

  describe "place model validations" do
    it "validates name and description are upcased" do
      expect(place.name).to eq("Chicago".upcase)
      expect(place.description).to eq("As a multicultural city that thrives on the harmony and diversity of its neighborhoods, Chicago today embodies the values of America's heartland-integrity, hard work and community and reflects the ideals in the social fabric of its 77 distinct neighborhoods.".upcase)
    end

    it "validates lat and long are numeric" do
      expect(place.latitude).to be_a_kind_of(Numeric)
      expect(place.longitude).to be_a_kind_of(Numeric)
    end
  end
end
