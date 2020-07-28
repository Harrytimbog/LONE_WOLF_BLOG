class ReviewsController < ApplicationController
  before_action :find_post
  before_action :find_review, only: [:destroy]

  def create
    if already_reviewed?
      flash[:notice] = "You can't review more than once"
    else
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
  end

  def destroy
    if !already_reviewed?
      flash[:notice] = "Cannot unreview"
    else
      @review.destroy
    end
    redirect_to post_path(@post)
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def find_post
    @post = Post.find(params[:post_id])
    authorize @post
  end

  def find_review
    @review = @post.reviews.find(params[:id])
    authorize @review
  end

  def already_reviewed?
    Review.where(user_id: current_user.id, post_id:
    params[:post_id]).exists?
  end
end
