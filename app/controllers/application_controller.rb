class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  helper_method :current_order

  def access_denied(exception)
    redirect_to root_path, alert: exception.message
  end

  def after_sign_in_path_for(resource)
    resource.is_admin? ? admin_root_path : root_path
  end

  def current_order
    return @current_order if @current_order
    @current_order = session[:order_id] ? Order.find(session[:order_id]) : Order.new
  end

end
