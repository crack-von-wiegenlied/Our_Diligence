class Public::CategoriesController < ApplicationController
  before_action :authenticate_user!

  def show
    @category = Category.find(params[:category_id])
    @posts = @category.posts
  end

end
