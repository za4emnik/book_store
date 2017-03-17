class OrderItemsController < ApplicationController
  before_action :create_order

  def create
    item = OrderItem.new
    item.book_id = params[:book_id]
    item.order_id = session[:order_id]
    item.save
  end

  private

  def create_order
    session[:order_id] ||= Order.create.id
  end
end
