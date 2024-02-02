class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email,:name,:user_type, :mobile_no])
  end
  
  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      if resource.has_user_type?('bus_owner')
        # new_user_session_path
        bus_owner_path
      elsif resource.has_user_type?('customer')
        # new_user_registration_path
        customer_path
      else
        root_path
      end
    end
  end
end
