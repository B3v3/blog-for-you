class ApplicationController < ActionController::Base
  include SessionsHelper

  private
  #for actions only for not logged in users
  def not_logged_in?
     if  current_user
       redirect_to current_user
     end
  end

  #for actions only for logged in users
  def logged_in?
     if current_user.nil?
       redirect_to root_path
     end
  end

  def not_owner_check(user)
    current_user != user
  end
end
