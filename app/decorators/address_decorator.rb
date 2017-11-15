class AddressDecorator < ApplicationDecorator
  delegate_all

  def show_selected_value
    model.country_id || I18n.t(:nothing_selected)
  end
end
