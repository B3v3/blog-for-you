class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = 'Your post has been created!'
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = "Your post has been updated!"
      redirect_to @post
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.delete
    redirect_to root_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
