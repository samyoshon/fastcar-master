# Buy or Lease

class PurchaseOption < ApplicationRecord
	belongs_to :proposal, optional: true
end
