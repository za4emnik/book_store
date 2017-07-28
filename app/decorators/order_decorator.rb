class OrderDecorator < ApplicationDecorator
  decorates_association :order_items

  def summary_coupon
    if model.coupon
      h.content_tag :tr do
        h.concat h.content_tag(:td, h.content_tag(:p, 'Coupon:', class: 'font-16'))
        h.concat h.content_tag(:td, h.content_tag(:p, "€#{model.coupon.value}", class: 'font-16'))
      end
    end
  end

  def summary_delivery
    if model.delivery
      h.content_tag :tr do
        h.concat h.content_tag(:td, h.content_tag(:p, 'Shipping:', class: 'font-16'))
        h.concat h.content_tag(:td, h.content_tag(:p, "€#{order.delivery.price}", class: 'font-16'))
      end
    end
  end

  def delete_button_header
    h.content_tag(:th, '', class: 'col-close') if is_cart_page?
  end

end
