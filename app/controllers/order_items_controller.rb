class OrderItemsController < ApplicationController

  def create
    item = current_order.order_items.where(book_id: params[:book_id]).first_or_initialize
    item.quantity += params[:order_item].present? ? params[:order_item][:quantity].to_i : 1
    item.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    OrderItem.delete params[:id]
    redirect_back(fallback_location: root_path)
  end
end
