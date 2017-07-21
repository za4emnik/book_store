class OrderItemDecorator < ApplicationDecorator

  def quantity_field(field, item)
    if is_cart_page?
      h.render partial: '/carts/quantity_field', locals: { field: field, item: item }
    else
      h.content_tag(:p, model.quantity)
    end
  end

  def delete_button(item)
    if is_cart_page?
      h.content_tag :td do
        h.content_tag(:a, h.content_tag(:span, '&times;'.html_safe, 'aria-hidden': "true"), class: 'close general-cart-close', href: h.order_item_path(item.id), 'aria-label': "Close", 'data-method': 'delete')
      end
    end
  end
end
