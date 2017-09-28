class BooksController < ApplicationController
  def show
    @book = Book.find params[:id]
    @review = Review.new
    @order_item = OrderItem.new
  end
end
