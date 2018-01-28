class Notification < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :recipient, class_name: "User", optional: true
  belongs_to :notifiable, polymorphic: true, optional: true
end
