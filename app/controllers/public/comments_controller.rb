class Public::CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.post_id = @post.id
    @comment.user_id = current_user.id
    @comment.save!
    redirect_to post_path(@post)
  end


  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
