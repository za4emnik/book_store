class ApplicationDecorator < Draper::Decorator

  delegate_all

  def edit_link
    if h.request.fullpath == h.wizard_path(:confirm)
      h.link_to t(:edit), h.wizard_path(:address), class: 'general-edit'
    end
  end

  def is_cart_page?
    h.request.fullpath == h.cart_page_path
  end

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
