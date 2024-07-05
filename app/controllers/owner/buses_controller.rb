class Owner::BusesController < ApplicationController
  before_action :authenticate_user!, except: %i[ new]
  before_action :set_bus, only: %i[ edit update destroy]
  before_action :authorize_owner, only: [:edit, :update, :destroy]

  def index
    current_user_id = current_user.id
    user = User.find(current_user_id)
    @owner_buses = user.buses
  end
  
  # GET /buses/new
  def new
    @bus = current_user.buses.build
    @bus.seats.build
    @bus.reservations.build
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bus
      @bus = Bus.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bus_params
      params.require(:bus).permit(:title, :total_seats, :source, :destination, :arrival_time, :departure_time, :registration_no)
    end

    def authorize_owner
      unless @bus.bus_owner == current_user
          flash[:alert] = "You are not authorised to this action"
          redirect_back(fallback_location: root_path)
      end
    end
end
