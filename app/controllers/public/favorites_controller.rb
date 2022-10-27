class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    favorite = Favorite.new(post_id: post.id, user_id: current_user.id)
    favorite.save
    redirect_back fallback_location: root_path
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = Favorite.find_by(post_id: post.id, user_id: current_user.id)
    favorite.destroy
    redirect_back fallback_location: root_path
  end

  def index
    favorites = Favorite.where(user_id: current_user.id).order(created_at: :DESC).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

end
