class ReservationsController < ApplicationController
  before_action :set_bus
  before_action :authenticate_user!
  # before_action :set_reservation

  def index
    @bus = Bus.find(params[:bus_id])
    @reservation_date = params[:reservation_date]
    @bus_reservations = @bus.reservations.where(reservation_date: @reservation_date)
  end

  def new
    @reservation = @bus.reservations.build
  end
  def create
    if params[:seat_ids].blank?
      flash[:alert] = 'Please select at least one seat.'
      redirect_back(fallback_location: root_path)
      return
    end
    reservation_date = params[:bus][:reservation_date]
    selected_seats = params[:seat_ids]
    check = false
    selected_seats.each do |seat_id|
      @reservation = @bus.reservations.build(user_id:current_user.id, bus_id:params[:bus_id], seat_id: seat_id, reservation_date: reservation_date)
      check = @reservation.save
      unless check 
        render :new, alert: 'Reservation is not created'
        return
      end
    end
    if check
      redirect_to @bus, notice: 'Reservation was successfully created.'
      return 
    else
      render :new, alert: 'Reservation is not created'
    end
  end

  def destroy
    bus_id = params[:bus_id]
    reservation_id = params[:id]

    @reservation = Reservation.find_by(id: reservation_id, bus_id: bus_id)

    if @reservation
      @reservation.destroy
      redirect_to customer_path, alert: "Booking successfully cancelled."
    else
      redirect_to customer_path, alert: "You can't cancel this reservation."
    end
  end

  def see_reservation
  end

  private
  def set_bus
    @bus = Bus.find(params[:bus_id])
  end
  # def set_reservation
  #   @reservation = @bus.reservations.find(params[:id])
  # end

  def reservation_params
    params.require(:reservation).permit(:seat_number, :passenger_name)
    # Add other permitted attributes
  end
end
