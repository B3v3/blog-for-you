class CommentsController < ApplicationController
  before_action :logged_in?

  def create
    @comment = post.comments.build(comment_params)
    @comment.user_id = current_user.id
      if @comment.save
        redirect_to post
      else
        flash[:danger] = 'You cant submit a post shorter than 2 characters
                          or longer than 256 characters!'
        redirect_to post
      end
  end

  def update
    @comment = post.comments.find(params[:id])
    if current_user == @comment.user
      @comment.update_column(:content, "Deleted by #{current_user.nickname}")
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def post
    @post ||= Post.find(params[:id])
  end
end
