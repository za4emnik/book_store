class CartsController < ApplicationController
  before_action :authenticate_user!, only: :update

  def index
    current_order.subtotal!
    current_order.update_total!
  end

  def update
    params[:order_items].each do |key, value|
      OrderItem.update(key, quantity: value[:quantity])
    end
    check_coupon if params[:order][:coupon].present?
    redirect_back(fallback_location: root_path)
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
