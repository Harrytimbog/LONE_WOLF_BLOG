class ReviewsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @review = Review.new(review_params)
    @review.post = @post
    @review.user = current_user
    if @review.save
      redirect_to post_path(@post)
    else
      flash[:alert] = "Something went wrong."
      render "posts/show"
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
