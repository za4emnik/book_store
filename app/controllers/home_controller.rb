class HomeController < ApplicationController

  def index
    @books = Book.first 2
    @bestsellers = Book.first 4
  end

end
