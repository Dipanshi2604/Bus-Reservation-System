class CustomerController < ApplicationController
  def index
    current_user_id = current_user.id
    user = User.find(current_user_id)
    @my_bookings = user.reservations 
    @bus = user.buses
  end
end
