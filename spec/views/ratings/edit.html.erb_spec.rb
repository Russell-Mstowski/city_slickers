require 'rails_helper'

RSpec.describe "ratings/edit", type: :view do
  let!(:place) { FactoryBot.create(:place) }
  let(:rating) { FactoryBot.create(:rating, place_id: place.id) }

  before(:each) do
    assign(:rating, rating)
  end

  it "renders the edit rating form" do
    render

    assert_select "form[action=?][method=?]", rating_path(rating), "post" do

      assert_select "input[name=?]", "rating[place_id]"

      assert_select "input[name=?]", "rating[value]"
    end
  end
end
