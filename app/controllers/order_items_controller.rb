class OrderItemsController < ApplicationController
  before_action :create_order

  def create
    order = Order.find session[:order_id]
    item = order.order_items.where(book_id: params[:book_id]).first_or_initialize
    item.quantity += params[:order_item].present? ? params[:order_item][:quantity].to_i : 1
    item.save
  end

  private

  def create_order
    session[:order_id] ||= Order.create(current_user).id
  end
end
