class BooksController < ApplicationController

  def show
    @book = Book.find params[:id]
    @review = Review.new
  end

end
