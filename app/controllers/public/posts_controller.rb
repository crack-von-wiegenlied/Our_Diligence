class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user, only: [:edit, :update]

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    if post.save
      redirect_to post_path(post)
    else
      render 'new'
    end
  end

  def index
    @user = current_user
    @posts = Post.order(created_at: :DESC)
  end

  def timeline
    @posts = Post.where(user_id: [current_user.id, *current_user.following_ids]).order(created_at: :DESC)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      redirect_to post_path(post)
    else
      render 'edit'
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to user_path(current_user)
  end


  private

  def post_params
    params.require(:post).permit(:category_id, :title, :body, :work_time, :start_time)
  end

  def category_params
    params.require(:category).permit(:name)
  end

 #URL直打ちでの編集画面遷移禁止
  def check_user
    @post = Post.find(params[:id])
    user = @post.user
    redirect_to post_path(@post) unless user == current_user
  end

end
