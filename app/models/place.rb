class Place < ApplicationRecord
  has_many :ratings
  
  # Upcase fields before persisting
  before_save :upcase_fields

  # Validate name & description are present
  validates :name, :description, presence: true

  # Validate lat & long are present & numeric in nature
  validates :latitude, :longitude, presence: true, numericality: true

  # Virtual attribute to present average rating
  attribute :average_rating

  # Limit pagination to 10 places
  self.per_page = 10

  # Average rating for a given Place rounded to 1 decimal places
  def rating
    self.ratings.average(:value).round(1)
  end

  private

  def upcase_fields
    self.name.upcase!
    self.description.upcase!
  end
end
