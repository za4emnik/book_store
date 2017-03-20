class HomeController < ApplicationController

  def index
    @books = Book.all
    @latest_books = Book.latest_books
    @bestsellers = Book.bestsellers(4)
  end

end
