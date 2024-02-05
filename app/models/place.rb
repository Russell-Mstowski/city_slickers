class Place < ApplicationRecord
  has_many :ratings

  # Average rating for a given Place rounded to 2 decimal places
  def rating
    self.ratings.average("value").round(2)
  end
end
