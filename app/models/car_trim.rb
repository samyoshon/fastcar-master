class CarTrim < ApplicationRecord
  belongs_to :car_year, optional: true
  belongs_to :car_make, optional: true
  belongs_to :car_model, optional: true
  has_many :car_colors
end
