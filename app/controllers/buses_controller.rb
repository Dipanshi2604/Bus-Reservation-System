class BusesController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]
  before_action :set_bus, only: %i[reservation_date available_seats]

  # GET /buses or /buses.json
  def index
    @buses = Bus.all
  end

  def reservation_date
    # rendering the from to select date for reservation
  end 
  
  def available_seats
    # showing available seat for new reservation on selected date from above fun
    @reservation = Reservation.new()
    @bus_seats = @bus.seats
    @reservation_seat_ids = @bus.reservations.where(reservation_date: params[:reservation_date]).pluck(:seat_id)  
  end

  # GET /buses/1 or /buses/1.json
  def show
    @buses = Bus.all.pluck(:id)
    if(@buses.include?(params[:id].to_i) == false)
      flash[:alert] = "Bus Not Found"
      redirect_back(fallback_location: root_path)
    else
      set_bus
    end
  end 

  def search_bus
    if request.referer.present?

      # check from which page the request is coming from 
      if request.referer.include?("http://localhost:3000/my_buses")
        @owner_buses = current_user.buses.where("source LIKE :search OR title LIKE :search OR destination LIKE :search", search: "%#{params[:search]}%")
        # Render bus owner's bus
        unless @owner_buses.empty?
          render 'owner/my_buses/index'
        else
          flash[:alert] = "Bus Not Found"
          redirect_back(fallback_location: root_path)
        end
      else
        # Render all buses page
        @buses = Bus.where("source LIKE :search OR title LIKE :search OR destination LIKE :search", search: "%#{params[:search]}%")
        if @buses
          render 'buses/index'
        else
          flash[:alert] = "Bus Not Found"
          redirect_back(fallback_location: root_path)
        end
      end

    else
      # Render home page
      render 'buses/index'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bus
      @bus = Bus.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bus_params
      params.require(:bus).permit(:title, :total_seats, :source, :destination, :arrival_time, :departure_time, :registration_no)
    end
end
