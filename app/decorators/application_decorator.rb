class ApplicationDecorator < Draper::Decorator
  
  delegate_all

  def edit_link
    if h.request.fullpath == h.wizard_path(:confirm)
      h.link_to 'edit', h.wizard_path(:address), class: 'general-edit'
    end
  end

  def is_cart_page?
    h.request.fullpath == h.cart_page_path
  end

end
