module BusesHelper
  def ownes_bus?
    @bus.bus_owner == current_user
  end
end
