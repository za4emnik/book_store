class OrdersController < ApplicationController

  def index
    @orders = current_user.orders.with_filter(params[:filter])
  end

  def show
    @order = Order.find params[:id]
  end

end
