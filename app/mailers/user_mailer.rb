class UserMailer < ActionMailer::Base
  default from: "no-reply@gpwanalizer.pl"
  
  def after_sign_up(user)
    @user = user
    @url  = 'http://gpwanalizer.pl'+auth_confirm_email_path+'?token='+@user.registration_hash
    mail(to: @user.email, subject: 'Witaj w aplikacji GPW Analizer')
  end
  
  def forgot_password(user)
    @user = user
    @url  = 'http://gpwanalizer.pl'+auth_forgot_password_path+'?token='+@user.password_hash
    mail(to: @user.email, subject: 'Reset hałsa do konta w GPW Analizer')
  end
end
