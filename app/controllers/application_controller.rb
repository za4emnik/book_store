class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:password, :confirm_password, :old_password)}
  end

  def access_denied(exception)
    redirect_to root_path, alert: exception.message
  end

  def after_sign_in_path_for(resource)
    resource.is_admin? ? admin_root_path : root_path
  end

end
