require 'rails_helper'

RSpec.describe "ratings/edit", type: :view do
  let(:rating) {
    Rating.create!(
      place_id: 1,
      value: 1.5
    )
  }

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
