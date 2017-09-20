class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    if current_user.reviews.create reviews_params
      flash[:success] = I18n.t(:thanks_for_review)
      redirect_to book_path(id: params[:review][:book_id])
    end
  end


  protected

  def reviews_params
    params.require(:review).permit(:title, :score, :message, :book_id)
  end
end
