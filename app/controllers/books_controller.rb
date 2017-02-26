class BooksController < ApplicationController

  def show

  end

  def create
    book = Book.new
    book.name = params[:name]
    book.description = params[:description]
    book.price = params[:price]
    book.save
  end

end
