class ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)
    @review.cocktail_id = params[:cocktail_id]
    @review.save

    redirect_to cocktail_path(params[:cocktail_id])
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
