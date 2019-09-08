class SignupMailer < ApplicationMailer
  def signup_mail(user)
    @user = user
    mail to: @user.email, subject: "会員登録完了"
  end
end
