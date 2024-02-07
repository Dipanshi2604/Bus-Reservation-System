class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email,:name,:user_type, :mobile_no])
  end
  
  def after_sign_in_path_for(resource)
    stored_location = session["user_return_to"]
    session["user_return_to"] = nil # Clear the stored location after using it
    return stored_location if stored_location

    if resource.is_a?(User)
      if resource.has_user_type?('bus_owner')
        bus_owner_path
      elsif resource.has_user_type?('customer')
        customer_path
      else
        root_path
      end
    else
      super
    end
  end
end
