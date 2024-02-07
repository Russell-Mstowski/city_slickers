require 'rails_helper'

RSpec.describe "ratings/show", type: :view do
  let!(:place) { FactoryBot.create(:place) }

  before(:each) do
    assign(:rating, Rating.create!(
      place_id: place.id,
      value: 3.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3.5/)
  end
end
