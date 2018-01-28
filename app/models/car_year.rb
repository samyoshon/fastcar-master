class CarYear < ApplicationRecord
	has_many :car_makes
	has_many :car_models
	has_many :car_trims
	has_many :car_colors
end
