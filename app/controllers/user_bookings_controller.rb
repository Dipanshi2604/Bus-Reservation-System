class UserBookingsController < ApplicationController
  before_action :authenticate_user!, only: %i[index]
  def index
    @my_bookings = current_user.reservations 
    @bus = current_user.buses
  end
end
