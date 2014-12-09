class UserMailer < ActionMailer::Base
  #default from: "from@example.com"

  def beta_invite(user)
    @user = user

    mail to: user.email, subject: "Tracie | Wir haben dich in die Beta aufgenommen"
  end
end
