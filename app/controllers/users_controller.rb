class UsersController < ApplicationController
  before_action :logged_in?, only: [:show, :edit, :update, :destroy]
  before_action :not_logged_in?, only: [:new, :create]

  #actions for logged in users
  def show
    @user = User.find(params[:id])
  end

  #actions to register a account
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome!"
      redirect_to @user
    else
      render 'new'
    end
  end

  #actions for owner of account
  def edit
    @user = User.find(params[:id])
    if not_owner_check(@user)
      redirect_to current_user
    end
  end

  def update
    @user = User.find(params[:id])
    if not_owner_check(@user)
      redirect_to current_user
    else
      if @user.update_attributes(user_params)
        flash[:success] = "Success!"
        redirect_to @user
      else
        render 'edit'
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    if not_owner_check(@user)
      redirect_to current_user
    else
      @user.delete
      redirect_to root_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:nickname, :email, :password,
                                                    :password_confirmation)
  end
end
