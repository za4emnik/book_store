class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def access_denied(exception)
    redirect_to root_path, alert: exception.message
  end

  def after_sign_in_path_for(resource)
    resource.is_admin? ? admin_root_path : root_path
  end

end
