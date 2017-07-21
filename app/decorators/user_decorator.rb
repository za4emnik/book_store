class UserDecorator < ApplicationDecorator
  delegate_all

  def show_billing_address
    h.render partial: '/checkout/address', locals: { obj: model.billing_address }
  end

  def show_shipping_address
    if model.shipping_address.use_billing_address
      show_billing_address
    else
      h.render partial: '/checkout/address', locals: { obj: model.shipping_address }
    end
  end

end
