module ApplicationHelper
  def get_sign_in_or_sign_out_link(options = {})
    if current_user 
      link_to "Sign Out", destroy_user_session_path, {
        data: {
          turbo_method: :delete,
          turbo_confirm: "Are you sure?"
        },
      class: "nav-link"
      }.merge(options)
    else
      link_to "Sign In", new_user_session_path, { class: "nav-link" }.merge(options)
    end
  end

  def get_user_email
    if current_user 
      current_user.email
    end
  end
end
