require 'rails_helper'

RSpec.describe "places/show", type: :view do
  let!(:place) { FactoryBot.create(:place) }

  before(:each) do
    assign(:place, place)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/#{place.name}/)
    expect(rendered).to match(/AS A MULTICULTURAL CITY THAT THRIVES ON THE HARMONY AND DIVERSITY OF ITS NEIGHBORHOODS, CHICAGO TODAY EMBODIES THE VALUES OF AMERICA&#39;S HEARTLAND-INTEGRITY, HARD WORK AND COMMUNITY AND REFLECTS THE IDEALS IN THE SOCIAL FABRIC OF ITS 77 DISTINCT NEIGHBORHOODS./)
    expect(rendered).to match(/#{place.longitude}/)
    expect(rendered).to match(/#{place.longitude}/)
  end
end
