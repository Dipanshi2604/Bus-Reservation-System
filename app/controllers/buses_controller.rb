class BusesController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]
  before_action :set_bus, only: %i[ show edit update destroy reservation_date available_seats]

  # GET /buses or /buses.json
  def index
    @buses = Bus.all
  end

  def reservation_date
    user_id = current_user.id
    bus_id = params[:bus_id] 
    @bus_seats = @bus.seats
    @reservation_seats = @bus.reservations.pluck(:seat_id)
  end 
  
  def available_seats
    @reservation = Reservation.new()
    user_id = current_user.id
    bus_id = params[:id] 
    @bus_seats = @bus.seats
    @reservation_seat_ids = @bus.reservations.where(reservation_date: params[:reservation_date]).pluck(:seat_id)  
    render 'available_seats'
  end

  # GET /buses/1 or /buses/1.json
  def show
  end

  # GET /buses/new
  def new
    @bus = current_user.buses.build
  end

  # GET /buses/1/edit
  def edit
  end

  # POST /buses or /buses.json
  def create
    @bus = current_user.buses.build(bus_params)
    
    respond_to do |format|
      if @bus.save
        format.html { redirect_to bus_url(@bus), notice: "Bus was successfully created." }
        format.json { render :show, status: :created, location: @bus }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bus.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /buses/1 or /buses/1.json
  def update
    respond_to do |format|
      if @bus.update(bus_params)
        format.html { redirect_to bus_url(@bus), notice: "Bus was successfully updated." }
        format.json { render :show, status: :ok, location: @bus }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bus.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buses/1 or /buses/1.json
  def destroy
    @bus.destroy!

    respond_to do |format|
      format.html { redirect_to buses_url, notice: "Bus was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search_bus
    if params[:search].present?
      @buses = Bus.where("source LIKE :search OR title LIKE :search OR destination LIKE :search", search: "%#{params[:search]}%")
    else
      @buses = Bus.all
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
