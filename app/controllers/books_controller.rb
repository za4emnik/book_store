class BooksController < ApplicationController
  def index
    @books = Book.with_filter(params[:filter]).page params[:page]
  end

  def show
    @book = Book.friendly.find params[:id]
    @review = Review.new
    @order_item = OrderItem.new
  end
end
