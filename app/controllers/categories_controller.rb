class CategoriesController < ApplicationController
  before_action :count_books

  def show
    @books = Category.friendly.find(params[:id]).books.with_filter(params[:filter]).page params[:page]
  end

  private

  def count_books
    @books_count = Book.count
  end
end
