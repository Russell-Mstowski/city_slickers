class Place < ApplicationRecord
  has_many :ratings
  
  before_save :upcase_fields

  validates :latitude, :longitude, numericality: true

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
