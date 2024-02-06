require 'json'

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


path = File.join(File.dirname(__FILE__), "./json/places.json")
places = JSON.parse(File.read(path))

places.each do |place| 
  pl = Place.create!(place)

  # Generate 10 random ratings for each place
  10.times do
    pl.ratings.create!({ value: rand(0.0...10.0).round(2)})
  end
end