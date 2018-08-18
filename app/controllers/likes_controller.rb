class LikesController < ApplicationController
  before_action :logged_in?

  def create
    post.likes.create(user: current_user)
    redirect_to post
  end

  def destroy
    post.likes.where(user: current_user).destroy_all
    redirect_to post
  end

  private
  def post
   @post ||= Post.find(params[:id])
  end
end
