class Public::OpinionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @opinion = Opinion.new
  end

  def index
    @opinions = Opinion.where(user_id: current_user.id)
  end

  def create
    @opinion = Opinion.new(opinion_params)
    @opinion.user_id = current_user.id
    if @opinion.save
      flash[:notice] = 'ご意見を送信しました'
      redirect_to opinions_path
    else
      render 'new'
    end
  end


  private

  def opinion_params
    params.require(:opinion).permit(:title, :body, :user_id)
  end

end
