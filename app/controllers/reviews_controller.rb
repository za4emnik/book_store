class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @review = current_user.reviews.create(reviews_params)
    if @review.errors.empty?
      flash[:success] = I18n.t(:thanks_for_review)
      book = Book.find params[:review][:book_id]
      redirect_to book_path(book)
    end
  end

  protected

  def reviews_params
    params.require(:review).permit(:title, :score, :message, :book_id)
  end
end
