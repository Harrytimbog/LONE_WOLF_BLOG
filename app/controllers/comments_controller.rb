class CommentsController < ApplicationController
  before_action :find_post
  before_action :find_comment, only: [:destroy]

def create
  @post = Post.find(params[:post_id])
  @comment = Comment.new(comment_params)
  @comment.post = @post
  @comment.user = current_user
  if @comment.save
    redirect_to post_path(@post, anchor: "comment-#{@comment.id}")
  else
    flash[:alert] = "Something went wrong."
    render "posts/show"
  end
  authorize @post
end

  def destroy
    @comment.destroy
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_comment
    @comment = @post.comments.find(params[:id])
    authorize @comment
  end
end
