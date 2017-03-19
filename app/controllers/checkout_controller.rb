class CheckoutController < ApplicationController
  include Wicked::Wizard

  before_action :order_to_user, only: [:index]

  steps :address, :delivery, :payment, :confirm

  def show
    case step
      when :address
        @billing_address = current_user.billing_address || AddressForm.new
        @shipping_address = current_user.shipping_address || AddressForm.new
        @address = AddressForm.new
      when :delivery
        @deliveries = Delivery.all
      when :payment
        @cart = current_order.cart || Cart.new
    end
    render_wizard
  end

  def update
    case step
      when :address
        current_user.billing_address.update_attributes(address_params(:billing_address))
        current_user.shipping_address.update_attributes(address_params(:shipping_address))
      when :delivery
        current_order.delivery_id = params[:order][:delivery]
        current_order.save
        current_order.update_total!
      when :payment
        cart = Cart.where(order_id: current_order).first_or_initialize
        cart.update_attributes!(params.require(:cart).permit(:number, :name, :date, :cvv))
      when :confirm
        current_order.waiting_processing!
    end
    render_wizard current_user
  end

  private

  def address_params(type)
    params.require(:address).require(type).permit(:first_name, :last_name, :address, :city, :zip, :country_id, :phone)
  end

  def finish_wizard_path
    success_path
  end

  def order_to_user
    current_order.user_id = current_user.id
    current_order.save
  end
end
