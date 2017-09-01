class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_variables, only: [:edit, :update]
  load_and_authorize_resource

  def update
    update_user_data ? redirect_to(settings_path) : render(:edit)
  end

  def destroy
    current_user.destroy
    redirect_to root_path
  end


  private

  def update_user_data
    case
    when params.include?('billing_form')
      update_billing
    when params.include?('shipping_form')
      update_shipping
    when params.include?('email_form')
      update_email
    when params.include?('password_form')
      update_password
    end
  end

  def update_billing
    @billing_address = BillingForm.new(address_params(:billing_form))
    if @billing_address.valid?
      current_user.build_billing_address unless current_user.billing_address
      current_user.billing_address.update_attributes(address_params(:billing_form))
    end
  end

  def update_shipping
    @shipping_address = ShippingForm.new(address_params(:shipping_form))
    if @shipping_address.valid?
      current_user.build_shipping_address unless current_user.shipping_address
      current_user.shipping_address.update_attributes(address_params(:shipping_form))
    end
  end

  def update_email
    current_user.update_email(params[:email_form][:email])
  end

  def update_password
    bypass_sign_in(current_user) if current_user.update(password_params)
  end

  def set_variables
    @billing_address = BillingForm.new(get_attributes('billing_address'))
    @shipping_address = ShippingForm.new(get_attributes('shipping_address'))
  end

  def get_attributes(type)
    current_user.public_send(type) ? current_user.public_send(type).attributes : nil
  end

  def address_params(type)
    params.require(type).permit(:first_name, :last_name, :address, :city, :zip, :country_id, :phone)
  end

  def password_params
    params.require(:password_form).permit(:password, :password_confirmation)
  end
end
