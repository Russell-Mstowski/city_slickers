class Rating < ApplicationRecord
  belongs_to :place

  # Validate that a Place is associated with a Rating
  validates_associated :place

  # Validate a value is present and numeric
  validates :value, presence: true, numericality: true
end
