class BusesController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]


  # GET /buses or /buses.json
  def index
    @buses = Bus.all
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
      if request.referer.include?("http://localhost:3000/buses")
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
