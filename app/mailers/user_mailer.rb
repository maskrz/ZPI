class UserMailer < ActionMailer::Base
  default from: "no-reply@gpwanalizer.pl"
  
  def after_sign_up(user)
    @user = user
    @url  = 'http://gpwanalizer.pl/auth/confirm_email?token='+@user.registration_hash
    mail(to: @user.email, subject: 'Witaj w aplikacji GPW Analizer')
  end
end
