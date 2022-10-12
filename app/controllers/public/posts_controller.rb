class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if params[:post][:category_select] == "2"
      category = Category.new
      @post.category_id = category.id
      category.save!
    end
    @post.user_id = current_user.id
    @post.save!
    redirect_to post_path(@post)


  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end

  private

  def post_params
    params.require(:post).permit(:category_id, :title, :body, :work_time, :start_time)
  end


end
