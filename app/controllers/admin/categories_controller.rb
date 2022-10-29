class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    category = Category.new(category_params)
    if category.save
      flash[:notice] = 'カテゴリーを追加しました'
      redirect_to admin_categories_path
    else
      flash[:notice] = 'カテゴリー名を入力してください'
      redirect_to admin_categories_path
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    category = Category.find(params[:id])
    if category.update(category_params)
      redirect_to admin_categories_path
    else
      flash[:notice] = 'カテゴリー名を入力してください'
      render 'edit'
    end
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy
    flash[:notice] = 'カテゴリーを削除しました'
    redirect_to admin_categories_path
  end


  private

  def category_params
    params.require(:category).permit(:name)
  end

end
