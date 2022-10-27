class Admin::OpinionsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @opinions = Opinion.order(created_at: :DESC)
  end

end
