class Reservation < ApplicationRecord
  # belongs_to :customer, class_name: 'User', foreign_key: 'customer_id'
  belongs_to :user
  belongs_to :bus
  belongs_to :seat
  validates :reservation_date, presence: true
end
