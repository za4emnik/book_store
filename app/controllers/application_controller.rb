class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  helper_method :current_order
  before_action :set_locale

  rescue_from CanCan::AccessDenied do |exeption|
    redirect_to main_app.root_path, notice: exeption.message
  end

  def after_sign_in_path_for(user)
    user.is_admin? ? rails_admin_path : root_path
  end

  def current_order
    return @current_order if @current_order
    @current_order = get_order
    session[:order_id] = @current_order.id
    @current_order
  end


  private

  def access_denied(exception)
    redirect_to root_path, alert: exception.message
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def get_order
    if session[:order_id]
      Order.where(id: session[:order_id], aasm_state: 'pending').first || Order.create!
    else
      Order.create!
    end
  end
end
