class Place < ApplicationRecord
  has_many :ratings
  
  before_save :upcase_fields

  validates :latitude, :longitude, numericality: true

  attribute :average_rating

  # Limit pagination to 10 places
  self.per_page = 10

  # Average rating for a given Place rounded to 2 decimal places
  def rating
    self.ratings.average(:value).round(2)
  end

  private

  def upcase_fields
    self.name.upcase!
    self.description.upcase!
  end
end
