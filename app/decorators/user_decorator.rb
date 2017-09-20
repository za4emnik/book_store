class UserDecorator < ApplicationDecorator
  delegate_all

  def verified_reviewer(id)
    if model.order_items.where(book_id: id).any?
      h.content_tag(:div, I18n.t(:verified_reviewer), class: 'general-message-verified')
    end
  end
end
