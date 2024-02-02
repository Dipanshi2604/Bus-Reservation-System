module ApplicationHelper
  def get_sign_in_or_sign_out_link
    if current_user 
      link_to "Sign Out", destroy_user_session_path, data: {
                        turbo_method: :delete,
                        turbo_confirm: "Are you sure?", class:"nav-link"
                        } 
      else
          link_to "Sign In", new_user_session_path, class:"nav-link"
      end
  end

  def get_user_email
    if current_user 
      current_user.email
    end
  end

  def if_bus_owner?
    if current_user
      if current_user.user_type == "bus_owner"
        link_to 'My Buses', bus_owner_path, class:"button"
      else
        link_to "My Bookings", customer_path, class: "button"
      end  
    end
  end
end
