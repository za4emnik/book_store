class CheckoutController < ApplicationController
  include Wicked::Wizard
  before_action :authenticate_user!, :order_to_user
  before_action :check_order, only: :show

  steps :address, :delivery, :payment, :confirm, :complete

  def show
    @form = StepShowService.new(step, current_order, session).form
    render_wizard
  end

  def update
    @form = StepUpdateService.new(step, current_order, params, session).update
    render_page
  end

  private

  def render_page
    if need_redirect?
      jump_to(:confirm)
      render_wizard
    else
      @form ? render_wizard(@form) : render_wizard(current_order)
    end
  end

  def need_redirect?
    session[:steps_taken?] &&
      request.fullpath != wizard_path(:confirm) &&
      (@form ? @form.valid? : true)
  end

  def finish_wizard_path
    categories_path
  end

  def order_to_user
    unless current_order.user
      current_order.user = current_user
      current_order.save
    end
  end

  def check_order
    unless [wizard_path(:complete), wizard_path(:wicked_finish)].include?(request.fullpath)
      redirect_to(carts_path) if current_order.order_items.blank?
    end
  end
end
