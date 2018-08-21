class CommentsController < ApplicationController
  before_action :logged_in?

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
      if @comment.save
        redirect_to @post
      else
        flash[:danger] = 'You cant submit a post shorter than 2 characters
                          or longer than 256 characters!'
        redirect_to @post
      end
  end

  def update
    @comment = Comment.find(params[:id])
    if current_user == @comment.user or @comment.post.user == current_user
      @comment.update_column(:content, "Deleted by #{current_user.nickname}")
      redirect_to @comment.post
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
