class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @billing_address = current_user.billing_address || BillingAddress.new
    @shipping_address = current_user.shipping_address || ShippingAddress.new
  end

  def update_shipping
    current_user.shipping_address ||= current_user.build_shipping_address
    current_user.shipping_address.update_attributes(address_params)
    redirect_to settings_path
  end

  def update_billing
    current_user.billing_address ||= current_user.build_billing_address
    current_user.billing_address.update_attributes(address_params)
    redirect_to settings_path
  end

  def update_email
    current_user.update(user_params)
    redirect_to settings_path
  end

  def update_password
    bypass_sign_in(current_user) if current_user.update(user_params)
    redirect_to settings_path
  end

  def destroy
    current_user.destroy
    redirect_to settings_path
  end


  protected


  def address_params
    address = params['shipping_address'].present? ? :shipping_address : :billing_address
    params.require(address).permit(:first_name, :last_name, :address, :city, :zip, :country_id, :phone)
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation, :email)
  end
end
