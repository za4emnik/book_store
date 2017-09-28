module ApplicationHelper
  def categories
    Category.all
  end

  def items_in_cart
    OrderItem.where(order_id: session[:order_id]).distinct.count(:book_id)
  end

  def markdown(text)
    if text
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new)
      markdown.render(text).html_safe
    end
  end

  def separated(obj, field = :name, mark = ', ')
    obj.map(&field).join(mark).html_safe
  end

  def show_errors(obj, field)
    obj.errors[field].join(', ')
  end

  def add_error_class(obj, field)
    'has-error' if obj.errors[field].any?
  end
end
