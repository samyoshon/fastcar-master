class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :image, ImageUploader
  acts_as_paranoid

  belongs_to :dealership, optional: true
  has_many :proposals
  has_many :responses
  has_many :reviews, :class_name => 'Review', :foreign_key => 'seller_id'
  has_many :reviews, :class_name => 'Review', :foreign_key => 'buyer_id'
  has_many :notifications, as: :recipient

  after_commit -> { NotificationRelayJob.perform_later(self) }
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def address
    [street, city, zipcode, state].compact.join(", ")
  end

  def address_changed?
    street_changed? || city_changed? || zipcode_changed? || state_changed?
  end

  def name
    if deleted_at?
      "Deleted User"
    else
      "#{first_name} #{last_name}"
    end
  end
end
