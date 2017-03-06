class CategoriesController < ApplicationController

  def show
    @books_count = Book.count
    @category = Category.find params[:id]
  end

end
