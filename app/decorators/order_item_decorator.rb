class OrderItemDecorator < ApplicationDecorator
  def quantity_field(field, item)
    if cart_page?
      h.render partial: '/carts/quantity_field', locals: { field: field, item: item }
    else
      h.content_tag(:p, model.quantity)
    end
  end

  def delete_button(item)
    if cart_page?
      h.content_tag :td do
        h.content_tag(:a, h.content_tag(:span, '&times;'.html_safe, 'aria-hidden': 'true'), class: 'close general-cart-close', href: h.order_item_path(item.id), 'aria-label': 'Close', 'data-method': 'delete')
      end
    end
  end

  def show_description
    if h.request.fullpath == h.checkout_path(:complete) || h.request.fullpath == h.orders_path
      h.markdown(model.book.description.split('.').first.concat('.'))
    end
  end
end
