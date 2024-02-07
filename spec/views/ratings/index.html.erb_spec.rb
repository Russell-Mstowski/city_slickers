require 'rails_helper'

RSpec.describe "ratings/index", type: :view do
  let!(:place) { FactoryBot.create(:place) }
  let!(:ratings) { [ FactoryBot.build(:rating, place_id: place.id), FactoryBot.build(:rating, place_id: place.id) ] }
  
  before(:each) do
    assign(:ratings, ratings)
  end

  it "renders a list of ratings" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(place.id.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(ratings.first.value.to_s), count: 1
    assert_select cell_selector, text: Regexp.new(ratings.second.value.to_s), count: 1
  end
end
