class ReviewsController < ApplicationController

  def create
    if current_user.reviews.create reviews_params
      redirect_to book_path(id: params[:review][:book_id])
    end
  end


  protected


  def reviews_params
    params.require(:review).permit(:title, :score, :message, :book_id)
  end
end
