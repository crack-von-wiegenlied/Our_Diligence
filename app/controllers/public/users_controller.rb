class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to user_path(user.id)
    else
      render 'edit'
    end
  end

  def unsubscribe
  end

  def withdraw
    user = current_user
    user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました。ご利用ありがとうございました。"
    redirect_to root_path
  end


  private
    def user_params
      params.require(:user).permit(:name, :introduction, :image, :email, :is_deleted)
    end

    #ゲストユーザーによるプロフィール編集禁止
    def ensure_guest_user
      @user = User.find(params[:id])
      if @user.name == "guestuser"
        redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集画面に遷移できません。"
      end
    end

end
