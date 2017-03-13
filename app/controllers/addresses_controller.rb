class AddressesController < ApplicationController

  def create
    current_user.account.billing_address = params
  end

  private

  def address_params
    params.permit(:first_name, :last_name)
  end

end