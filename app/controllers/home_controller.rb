class HomeController < ApplicationController

  def index
    @latest_books = Book.with_category_filter(params['category']).latest_books(3)
    @bestsellers = Book.with_category_filter(params['category']).bestsellers(4)
  end

end
