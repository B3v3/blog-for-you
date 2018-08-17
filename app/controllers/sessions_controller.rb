class SessionsController < ApplicationController
  before_action :logged_in?, only: [:destroy]
  before_action :not_logged_in?, only: [:new, :create]

  #actions to log in
  def new
  end

  def create
    user = User.find_by(email: params[:sessions][:email].downcase)
    if user && user.authenticate(params[:sessions][:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'bad combo :-c'
      render 'new'
    end
  end

  #action to log out
  def destroy
    log_out
    redirect_to root_path
  end
end
