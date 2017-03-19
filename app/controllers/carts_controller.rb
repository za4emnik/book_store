class CartsController < ApplicationController

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

end
