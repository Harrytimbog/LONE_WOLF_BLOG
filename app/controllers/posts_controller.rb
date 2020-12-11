class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  skip_after_action :verify_policy_scoped, only: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  def index
    @categories = Category.all

    cate = params[:cate]

    if !cate.nil?
      @posts = Post.where(category_id: cate)
    else
      @posts = policy_scope(Post).order(created_at: :desc)
    end
    authorize @posts
  end

  # GET /posts/1
  def show
    @review = Review.new
    @comment = Comment.new
  end

  # GET /posts/new
  def new
    @post = Post.new
    authorize @post
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.owner = current_user

    if @post.save
      redirect_to post_path(@post), notice: 'post was successfully created.'
    else
      render :new
    end
    authorize @post
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'post was successfully updated.'
    else
      render :edit
    end
    authorize @post
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    redirect_to posts_path, notice: 'post was successfully destroyed.'
    authorize @post
  end

  def my_posts
    @my_posts = Post.where(owner_id: current_user.id)
    authorize @my_posts
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
    authorize @post
  end

  # Only allow a trusted parameter "white list" through.
  def post_params
    params.require(:post).permit(:title, :status, :rich_body, :category_id, photos: [])
  end
end
