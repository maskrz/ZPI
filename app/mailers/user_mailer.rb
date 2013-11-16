class UserMailer < ActionMailer::Base
  default from: "no-reply@gpwanalizer.pl"
  
  def after_sign_up(user)
    @user = user
    @url  = 'http://gpwanalizer.pl'+auth_confirm_email_path+'?token='+@user.registration_hash
    mail(to: @user.email, subject: 'Witaj w aplikacji GPW Analizer')
  end
  
  def reset_password(user)
    @user = user
    @url  = 'http://gpwanalizer.pl'+auth_change_password_path+'?token='+@user.password_hash
    mail(to: @user.email, subject: 'Reset halsa do konta w GPW Analizer')
  end
end
