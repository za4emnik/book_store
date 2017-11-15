class OrdersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @orders = current_user.orders.with_filter(params[:filter]).where.not(aasm_state: 'pending')
  end

  def show
    @order = Order.find(params[:id]).decorate
  end
end
