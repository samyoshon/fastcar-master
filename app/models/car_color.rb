class CarColor < ApplicationRecord
	belongs_to :car_year, optional: true
	belongs_to :car_make, optional: true
	belongs_to :car_model, optional: true
	belongs_to :car_trim, optional: true
end
