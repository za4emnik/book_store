class CategoriesController < ApplicationController
  before_action :count_books

  def index
    @books = Book.with_filter(params[:filter]).page params[:page]
  end

  def show
    @books = Book.where(category_id: params[:id]).with_filter(params[:filter]).page params[:page]
  end

  private

  def count_books
    @books_count = Book.count
  end
end
