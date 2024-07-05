class ReservationsController < ApplicationController
  before_action :set_bus
  before_action :authenticate_user!

  def new
    if params[:reservation_date] == ""
      params[:reservation_date] = Date.today
    end
    @bus_seats = @bus.seats
    @reservation_seat_ids = @bus.reservations.where(reservation_date: params[:reservation_date]).pluck(:seat_id)  
    @bus_seats.each { |seat| @bus.reservations.build(seat: seat, reservation_date: params[:reservation_date], user_id: current_user.id) if !@reservation_seat_ids.include?(seat.id) }
  end

  def create_reservation
    if @bus.update(reservation_params)
      redirect_to @bus, notice: 'Reservations were successfully created.'
    else
      # if you dont want to persist the data
      flash[:alert] = 'Reservations NOT created.'
      redirect_back(fallback_location: root_path) 
      # render :new
    end
  end

  def create
    if @bus.update(reservation_params)
      redirect_to @bus, notice: 'Reservations were successfully created.'
    else
      # if you dont want to persist the data
      redirect_back(fallback_location: root_path)
      # render :new
    end
    # fail
    # reservation_date = reservation_params[:reservation_date]
    # selected_seats = reservation_params[:seat_ids].map(&:to_i) unless reservation_params[:seat_ids].blank?
    # @bus_reserved_ids = @bus.reservations.where(reservation_date: reservation_date).pluck(:seat_id)
    
    # if selected_seats.blank?
    #   flash[:alert] = 'Please select at least one seat.'
    #   redirect_back(fallback_location: root_path)
    #   return
    # end
    # # it is creating array of hashes (attributes)
    # reservations_attributes = selected_seats.map do |seat_id|
    #   if @bus_reserved_ids.include?(seat_id)
    #     flash[:alert] = "You can't book an already booked seat."
    #     redirect_back(fallback_location: root_path)
    #     return
    #   else
    #     {
    #       user_id: current_user.id,
    #       bus_id: reservation_params[:bus_id],
    #       seat_id: seat_id,
    #       reservation_date: reservation_date
    #     }
    #   end
    # end
    # Reservation.transaction do
    #   reservations = @bus.reservations.create(reservations_attributes)
    #   # it is creating all reservation at once
    #   if reservations.all?(&:persisted?)
    #     redirect_to @bus, notice: 'Reservations were successfully created.'
    #   else
    #     flash[:alert] = 'Some reservations were not created.'
    #     redirect_back(fallback_location: root_path)
    #     raise ActiveRecord::Rollback # Rollback the transaction
    #   end
    # end
  end
  
  def destroy
    bus_id = params[:bus_id]
    reservation_id = params[:id]

    @reservation = Reservation.find_by(id: reservation_id, bus_id: bus_id)

    if @reservation
      @reservation.destroy
      redirect_to user_bookings_path, alert: "Booking successfully cancelled."
    else
      redirect_to user_bookings_path, alert: "You can't cancel this reservation."
    end
  end

  private
  def set_bus
    @bus = Bus.find(params[:bus_id])
  end

  def reservation_params
    #params.require(:reservation).permit(:bus_id, :reservation_date, seat_ids:[],reservations: [:seat_id] )
    params.require(:bus).permit(reservations_attributes: [:seat_id, :reservation_date,:bus_id, :user_id])
  end
end
