class OrderItemsController < ApplicationController

  def create
    create_and_set_quantity
    redirect_back(fallback_location: root_path)
  end

  def destroy
    authorize! :all_excluding_create, OrderItem.find(params[:id])
    OrderItem.delete params[:id]
    redirect_back(fallback_location: root_path)
  end

  private

  def create_and_set_quantity
    item = current_order.order_items.where(book_id: params[:book_id]).first_or_initialize
    item.quantity += params[:order_item].present? ? params[:order_item][:quantity].to_i : 1
    item.save
  end
end
