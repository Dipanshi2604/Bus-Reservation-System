class CustomerController < ApplicationController
  before_action :authenticate_user!, only: %i[index]
  def index
    current_user_id = current_user.id
    user = User.find(current_user_id)
    @my_bookings = user.reservations 
    @bus = user.buses
  end
end
