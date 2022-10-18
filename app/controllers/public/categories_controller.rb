class Public::CategoriesController < ApplicationController

  def create
    category = Category.new(category_params)
    category.save
  end

  def show
    @category = Category.find(params[:category_id])
    @posts = @category.posts
  end


  private
  def category_params
    params.require(:category).permit(:name)
  end

end
