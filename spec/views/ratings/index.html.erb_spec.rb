require 'rails_helper'

RSpec.describe "ratings/index", type: :view do
  before(:each) do
    assign(:ratings, [
      Rating.create!(
        place_id: 2,
        value: 3.5
      ),
      Rating.create!(
        place_id: 2,
        value: 3.5
      )
    ])
  end

  it "renders a list of ratings" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.5.to_s), count: 2
  end
end
