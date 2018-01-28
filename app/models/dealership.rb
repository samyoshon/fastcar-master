class Dealership < ApplicationRecord
	has_many :users
	belongs_to :car_make, optional: true
	geocoded_by :address
	after_validation :geocode, if: :address_changed?

	def address
		[street, city, zipcode, state].compact.join(", ")
	end

	def address_changed?
		street_changed? || city_changed? || zipcode_changed? || state_changed?
	end
end
