class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @review = current_user.reviews.create(reviews_params)
    redirect_to_reviews_book if @review.errors.empty?
  end

  private

  def reviews_params
    params.require(:review).permit(:title, :score, :message, :book_id)
  end

  def redirect_to_reviews_book
    flash[:success] = I18n.t(:thanks_for_review)
    book = Book.friendly.find params[:review][:book_id]
    redirect_to book_path(book)
  end
end
