require 'rails_helper'

RSpec.describe Rating, type: :model do
  let!(:place) { FactoryBot.create(:place) }
  let!(:rating) { FactoryBot.build(:rating, place_id: place.id) }
  
  before { rating.save! }

  describe "rating model validations" do
    it "validates a place exists and value is numeric" do
      expect(rating.place_id).to eq(place.id)
      expect(rating.value).to be_a_kind_of(Numeric)
    end
  end
end
