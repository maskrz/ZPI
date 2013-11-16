class AuthController < ApplicationController
  require 'digest/md5'
  def login
    user = User.where(email: params[:login][:email]).first
    
    if user
      if user.is_active?
        if user.authenticate(params[:login][:password])
          user.last_logged_at = DateTime.now
          user.save
          
          user_sign_in user.id
          set_login_cookie if params[:login][:remember_me] == 1
          
          redirect_to root_path, success: 'Signed in!'
        else
          redirect_to root_path, error: 'Wrong email/password'
        end
      else
        redirect_to root_path, error: 'Your account is inactive. Please activate it to sign in'
      end
    else
      redirect_to root_path, error: 'Account does not exists'
    end
  end
  
  def logout
    if user_signed_in?
      user_sign_out
      redirect_to root_path, success: 'Signed out!'
    else
      redirect_to root_path, error: 'You are not signed in. Can not sing out.'
    end
  end
  
  def register
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        
        UserMailer.after_sign_up(@user).deliver
        
        format.html { redirect_to root_path, notice: "Thank you for account registration. For further actions please confirm your account by clicking link from email" }
      else
        format.html { render 'home/index', notice: @user.errors }
      end
    end
  end
  
  def forgot_password
    if request.post?
      @user = User.where(email: params[:user][:email]).first
      if @user
        @user.password_hash = Digest::MD5.hexdigest(@user.password)
        UserMailer.reset_password(@user).deliver
        redirect_to root_path, success: "Check your email and restore access to your account!" 
      else
        redirect_to root_path, error: "No account has been registered for typed email address"
      end
    end
  end
  
  def confirm_email
    token = params[:token]
    users = User.where(registration_hash: token)
    if users.any?
      user = users.first
      user.registration_hash = nil
      user.status = 1
      user.save
      redirect_to root_path, success: "Your account has been activated. Feel free to sign in!" 
    else
      redirect_to root_path, error: "Your account has not been activated. Plase check registration token"
    end
  end
  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :accept_statuate)
    end
end
