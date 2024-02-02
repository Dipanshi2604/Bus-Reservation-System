class ReservationsController < ApplicationController
  before_action :set_bus
  # before_action :set_reservation

  def new
    @reservation = @bus.reservations.build
  end
  # {"authenticity_token"=>"[FILTERED]", "bus"=>{"reservation_date"=>"2024-02-03", "seat_ids["=>{"]"=>"2"}}, "commit"=>"Submit", "bus_id"=>"4"}
  # {"authenticity_token"=>"[FILTERED]", "bus"=>{"reservation_date"=>"2024-02-02"}, "seat_ids"=>["2", "17"], "commit"=>"Submit", "bus_id"=>"4"}
  def create
    reservation_date = params[:bus][:reservation_date]
    selected_seats = params[:seat_ids]
    selected_seats.each do |seat_id|
      @reservation = @bus.reservations.build(user_id:current_user.id, bus_id:params[:bus_id], seat_id: seat_id, reservation_date: reservation_date)
      if @reservation.save
        redirect_to @bus, notice: 'Reservation was successfully created.'
        return 
      else
        render :new
      end
    end
  end

  def destroy
    bus_id = params[:bus_id]
    reservation_id = params[:id]

    @reservation = Reservation.find_by(id: reservation_id, bus_id: bus_id)

    if @reservation
      @reservation.destroy
      redirect_to customer_path, notice: "Booking successfully cancelled."
    else
      redirect_to customer_path, alert: "You can't cancel this reservation."
    end
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
