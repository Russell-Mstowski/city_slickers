require 'rails_helper'

RSpec.describe "places/index", type: :view do
  let!(:places) { [ FactoryBot.create(:place) ] }

  before(:each) do
    assign(:places, places)
  end

  it "renders a list of places" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(places.first.name.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(places.first.description.to_s), count: 1
    assert_select cell_selector, text: Regexp.new(places.first.latitude.to_s), count: 1
    assert_select cell_selector, text: Regexp.new(places.first.longitude.to_s), count: 1
  end
end
