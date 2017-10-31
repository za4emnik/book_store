class OrderItemsController < ApplicationController
  def create
    save_quantity
    redirect_back(fallback_location: root_path)
  end

  def destroy
    authorize! :all_excluding_create, OrderItem.find(params[:id])
    OrderItem.delete params[:id]
    redirect_back(fallback_location: root_path)
  end

  private

  def save_quantity
    item = current_order.order_items.where(book_id: params[:book_id]).first_or_initialize
    item.quantity = quantity
    item.save
  end

  def quantity
    quantity = params[:order_item]&.[](:quantity).to_i
    quantity.positive? ? quantity : 1
  end
end
