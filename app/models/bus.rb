class Bus < ApplicationRecord
  belongs_to :bus_owner, class_name: 'User'
  has_many :seats, dependent: :destroy
  has_many :reservations, dependent: :destroy
  accepts_nested_attributes_for :reservations, reject_if: proc { |obj| obj[:seat_id].blank? }

  after_create :create_seats
  validates :title, :total_seats, :source, :destination,:arrival_time, :departure_time, :registration_no, presence: true
  validates :total_seats, numericality: { only_integer: true, greater_than: 0 }, if: :total_seats_present?
  validates :source, format: { with: /\A[a-zA-Z]+\z/, message: "should only contain letters" }, if: -> { validate_source? }
  validates :destination, format: { with: /\A[a-zA-Z]+\z/, message: "should only contain letters" }, if: -> { validate_destination? }
  

  def total_seats_present?
    total_seats.present?
  end
  def validate_source?
    source.present?
  end
  def validate_destination?
    destination.present?
  end
  def create_seats
    # Create seats for the bus
    (1..total_seats).each do |seat_no|
      seats.create(seat_no: seat_no, seat_status: false)
    end
  end
end
