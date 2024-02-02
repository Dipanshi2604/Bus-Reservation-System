class Bus < ApplicationRecord
  belongs_to :bus_owner, class_name: 'User'
  has_many :seats, dependent: :destroy
  has_many :reservations, dependent: :destroy
  after_create :create_seats

  private

  def create_seats
    # Create seats for the bus
    (1..total_seats).each do |seat_no|
      seats.create(seat_no: seat_no, seat_status: false)
    end
  end

end
