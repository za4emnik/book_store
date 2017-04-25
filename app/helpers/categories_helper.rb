module CategoriesHelper

  def filter_state
    params[:filter].humanize if params[:filter]
  end
end
