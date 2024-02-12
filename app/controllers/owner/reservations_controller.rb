class Owner::ReservationsController < ApplicationController
  before_action :set_bus
  before_action :authenticate_user!
  # before_action :set_reservation

  def index
    @bus = Bus.find(params[:bus_id])
    @reservation_date = params[:reservation_date]
    @bus_reservations = @bus.reservations.where(reservation_date: @reservation_date)
  end

  private
  def set_bus
    @bus = Bus.find(params[:bus_id])
  end

  def reservation_params
    params.require(:reservation).permit(:bus_id, :reservation_date, seat_ids: [])
  end
end
