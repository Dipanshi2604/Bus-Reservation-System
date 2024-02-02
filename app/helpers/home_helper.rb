module HomeHelper
  def is_bus_owner?
    current_user && current_user.user_type  == "bus_owner"
  end
end
