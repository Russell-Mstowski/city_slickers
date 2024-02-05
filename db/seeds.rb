# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Drop places
Place.delete_all

# Reset ID count
ActiveRecord::Base.connection.reset_pk_sequence!('places')

# Drop ratings
Rating.delete_all

# Reset ID count
ActiveRecord::Base.connection.reset_pk_sequence!('ratings')

# {
#   latitude: 0.0,
#   longitude: 0.0,
#   name: "",
#   description: ""
# }

places = [
  {
    latitude: 41.8781,
    longitude: 87.6298,
    name: "Chicago",
    description: "As a multicultural city that thrives on the harmony and diversity of its neighborhoods, Chicago today embodies the values of America's heartland-integrity, hard work and community and reflects the ideals in the social fabric of its 77 distinct neighborhoods."
  },
  {
    latitude: 40.7128,
    longitude: 74.0060,
    name: "New York",
    description: "New York is composed of five boroughs – Brooklyn, the Bronx, Manhattan, Queens and Staten Island - is home to 8.4 million people who speak more than 200 languages, hail from every corner of the globe, and, together, are the heart and soul of the most dynamic city in the world."
  },
  {
    latitude: 34.0549,
    longitude: 118.2426,
    name: "Los Angeles",
    description: "The huge, sprawling, and tortuously shaped city of Los Angeles occupies a sizable portion of the southern part of the county. It too has a varied topography, climbing from sea level at the beach community of Venice to Mount Lukens, which rises above 5,100 feet (1,550 metres)."
  },
]

places.each do |place| 
  pl = Place.create!(place)

  # Generate 5 random ratings for each place
  5.times do
    pl.ratings.create!({ value: rand(0.0...10.0).round(2)})
  end
end