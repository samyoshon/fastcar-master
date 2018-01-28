class CarModel < ApplicationRecord
	default_scope { order(:name) } 
	has_many :proposals

	belongs_to :car_year, optional: true
	belongs_to :car_make, optional: true
	has_many :car_trims
	has_many :car_colors
end
