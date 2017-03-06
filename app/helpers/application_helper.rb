module ApplicationHelper

  def categories
    Category.all
  end

  def markdown(text)
    if text
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new)
      markdown.render(text).html_safe
    end
  end

  def separated(obj, field=:name, mark=', ')
    obj.map(&field).join(mark).html_safe
  end

end
