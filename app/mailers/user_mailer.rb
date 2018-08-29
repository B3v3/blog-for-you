class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.notify_user.subject
  #
  def notify_user(user, post)
    @post = post
    mail to: user.email, subject: "New post on Blog-for-you-site!"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end
  
end
