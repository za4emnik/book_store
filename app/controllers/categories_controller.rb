class CategoriesController < ApplicationController

  def index
    @books_count = Book.count
    @books = Book.with_filter(params[:filter]).page params[:page]
  end

  def show
    @books_count = Book.count
    @books = Book.where(category_id: params[:id]).with_filter(params[:filter]).page params[:page]
  end

end
