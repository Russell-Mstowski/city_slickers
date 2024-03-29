require 'rails_helper'

RSpec.describe "ratings/new", type: :view do
  let!(:place) { FactoryBot.create(:place) }

  before(:each) do
    assign(:rating, FactoryBot.build(:rating, place_id: place.id))
  end

  it "renders new rating form" do
    render

    assert_select "form[action=?][method=?]", ratings_path, "post" do

      assert_select "input[name=?]", "rating[place_id]"

      assert_select "input[name=?]", "rating[value]"
    end
  end
end
