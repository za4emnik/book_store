class ApplicationController < ActionController::Base
  before_filter :reload_rails_admin, if: :rails_admin_path?
  protect_from_forgery with: :null_session
  helper_method :current_order

  rescue_from CanCan::AccessDenied do |exeption|
    redirect_to main_app.root_path, notice: exeption.message
  end


  def access_denied(exception)
    redirect_to root_path, alert: exception.message
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

  def get_order
    if session[:order_id]
      Order.where(id: session[:order_id], aasm_state: 'pending').first || Order.create!
    else
      Order.create!
    end
  end

  def reload_rails_admin
    models = %W(Book Order Review)
    models.each do |m|
      RailsAdmin::Config.reset_model(m)
    end
    RailsAdmin::Config::Actions.reset

    load("#{Rails.root}/config/initializers/rails_admin.rb")
  end

  def rails_admin_path?
    controller_path =~ /rails_admin/ && Rails.env.development?
  end

end
