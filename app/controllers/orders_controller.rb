class OrdersController < ApplicationController

  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find params[:id]
  end

  def success
    @order = current_user.orders.where.not(aasm_state: 'pending').order(:created_at).first
  end

  private

  def check_coupon
    coupon = Coupon.where(code: params[:order][:coupon], active: true).first
    if coupon
      coupon.active = false
      current_order.coupon = coupon
    end
  end
end
