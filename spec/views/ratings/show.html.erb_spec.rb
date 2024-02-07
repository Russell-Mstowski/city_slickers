require 'rails_helper'

RSpec.describe "ratings/show", type: :view do
  let!(:place) { FactoryBot.create(:place) }
  let!(:rating) { FactoryBot.create(:rating, place_id: place.id) }

  before(:each) do
    assign(:rating, rating)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/#{place.id}/)
    expect(rendered).to match(/#{rating.value}/)
  end
end
