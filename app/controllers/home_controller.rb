class HomeController < ApplicationController

  def index
    @books = Book.all
    #category =
    @latest_books# = Book.find(category: params['category']).last(3)
    @bestsellers = Book.first 4
  end

end
