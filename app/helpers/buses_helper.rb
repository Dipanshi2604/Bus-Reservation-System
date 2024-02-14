module BusesHelper
  def ownes_bus?
    @bus.bus_owner == current_user
  end
  def is_bus_owner?
    current_user && current_user.bus_owner?
  end
end
