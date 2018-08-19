class PostsController < ApplicationController
  before_action :logged_in?

  #actions for logged in users
  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      current_user.notify_followers
      flash[:success] = 'Your post has been created!'
      redirect_to @post
    else
      render 'new'
    end
  end

  #actions for owners of posts
  def edit
    @post = Post.find(params[:id])
    if not_owner_check(@post.user)
      redirect_to current_user
    end
  end

  def update
    @post = Post.find(params[:id])
    if not_owner_check(@post.user)
      redirect_to current_user
    else
      if @post.update_attributes(post_params)
        flash[:success] = "Your post has been updated!"
        redirect_to @post
      else
        render "edit"
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if not_owner_check(@post.user)
      redirect_to current_user
    else
      @post.delete
      redirect_to root_path
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
