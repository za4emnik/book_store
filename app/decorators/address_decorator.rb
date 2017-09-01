class AddressDecorator < ApplicationDecorator
  delegate_all

  def show_selected_value
    model.country_id || 'Nothing selected'
  end
end
