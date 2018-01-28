class Proposal < ApplicationRecord
	include HTTParty
	belongs_to :user, optional: true
	belongs_to :car_make, optional: true
	belongs_to :car_model, optional: true
	has_many :responses

	geocoded_by :address
	after_validation :geocode, if: :address_changed?

	def address
		[street, city, zipcode, state].compact.join(", ")
	end

	def address_changed?
		street_changed? || city_changed? || zipcode_changed? || state_changed?
	end
end

