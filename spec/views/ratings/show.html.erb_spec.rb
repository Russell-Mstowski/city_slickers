require 'rails_helper'

RSpec.describe "ratings/show", type: :view do
  before(:each) do
    assign(:rating, Rating.create!(
      place_id: 2,
      value: 3.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3.5/)
  end
end
