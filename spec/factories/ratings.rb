# frozen_string_literal: true

FactoryBot.define do
  factory :rating, class: 'Rating' do
    place_id { 1 }
    value { rand(0.0...10.0).round(1) }
  end
end