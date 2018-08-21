class LikesController < ApplicationController
  before_action :logged_in?

  def create
    @post = Post.find(params[:post_id])
    @post.likes.create(user: current_user)
    redirect_to @post
  end

  def destroy
    @post = Like.find(params[:id]).post
    @post.likes.where(user: current_user).destroy_all
    redirect_to @post
  end
end
