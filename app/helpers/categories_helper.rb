module CategoriesHelper
  def filter_state
    params[:filter]&.humanize
  end
end
