class UsersController < ApplicationController

  def edit
    @billing_address = current_user.billing_address || BillingAddress.new
    @shipping_address = current_user.shipping_address || ShippingAddress.new
  end

  def save_shipping_address
    current_user.shipping_address ||= current_user.build_shipping_address
    current_user.shipping_address.update_attributes(address_params)
    redirect_to settings_path
  end

  def save_billing_address
    current_user.billing_address ||= current_user.build_billing_address
    current_user.billing_address.update_attributes(address_params)
    redirect_to settings_path
  end

  protected

  def address_params
    address = params['shipping_address'].present? ? :shipping_address : :billing_address
    params.require(address).permit(:first_name, :last_name, :address, :city, :zip, :country, :phone)
  end
end
