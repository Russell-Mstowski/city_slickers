# frozen_string_literal: true

FactoryBot.define do
  factory :place, class: 'Place' do
    name { "Chicago" }
    description { "As a multicultural city that thrives on the harmony and diversity of its neighborhoods, Chicago today embodies the values of America's heartland-integrity, hard work and community and reflects the ideals in the social fabric of its 77 distinct neighborhoods." }
    latitude { 41.8781136 }
    longitude { -87.6297982 }
  end
end