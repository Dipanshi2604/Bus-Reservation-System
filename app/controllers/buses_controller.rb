class BusesController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]
  before_action :set_bus, only: %i[ show edit update destroy book_ticket show_ticket]

  # GET /buses or /buses.json
  def index
    @buses = Bus.all
  end

  def book_ticket
    user_id = current_user.id
    bus_id = params[:bus_id] 
    @bus_seats = @bus.seats
    @reservation = @bus.reservations
    @reservation_seats = @reservation.pluck(:seat_id)
  end 
  
  def show_ticket
    user_id = current_user.id
    bus_id = params[:bus_id] 
    # reservation_date = params[:reservation_date]
    @bus_seats = @bus.seats
    @reservation = @bus.reservations.where(reservation_date: params[:reservation_date])
    @reservation_seats = @reservation.pluck(:seat_id)
    render 'show_ticket'
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
