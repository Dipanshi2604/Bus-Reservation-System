class BusOwnerController < ApplicationController
  def index
    current_user_id = current_user.id
    user = User.find(current_user_id)
    @owner_buses = user.buses
  end

end
