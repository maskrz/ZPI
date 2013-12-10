class AuthController < PortalController
  require 'digest/md5'
  
  def login
    user = User.where(email: params[:login][:email]).first
    
    if user
      if user.is_active?
        if user.authenticate(params[:login][:password])
          user.last_logged_at = DateTime.now
          user.save
          
          user_sign_in user.id
          set_login_cookie if params[:login][:remember_me] == '1'
          
          redirect_to root_path, success: t('auth.success_sign_in')
        else
          redirect_to root_path, error: t('auth.wrong_email')
        end
      else
        redirect_to root_path, error: t('auth.inactive_email')
      end
    else
      redirect_to root_path, error: t('auth.doesnt_exist')
    end
  end
  
  def logout
    if user_signed_in?
      user_sign_out
      redirect_to root_path, success: t('auth.success_sign_out')
    else
      redirect_to root_path, error: t('auth.failure_sign_out')
    end
  end
  
  def register
    @user = User.new(user_params)

    if @user.valid?
      
      UserMailer.after_sign_up(@user).deliver
      @user.save
      redirect_to root_path, notice: t('auth.registration_success')
    else
      redirect_to root_path, error: @user.errors.values.join('<br>').html_safe
    end
  end
  
  def forgot_password
    if request.post?
      users = User.where(email: params[:user][:email])
      if users.any?
        user = users.first
        user.password_hash = Digest::MD5.hexdigest(DateTime.now.to_s + user.password)
        user.save
        UserMailer.reset_password(user).deliver
        redirect_to root_path, success: t('auth.restore_success') 
      else
        redirect_to root_path, error: t('auth.restore_failure') 
      end
    end
  end
  
  def change_password
    @token = params[:token] || params[:user][:token]
    users = User.where(password_hash: @token)
    if users.any?
      @user = users.first
      if request.post?
        @user.password = params[:user][:password]
        @user.password_confirmation = params[:user][:password_confirmation]
        if @user.valid?
          @user.password = @user.password_confirmation = Digest::MD5.hexdigest(params[:user][:password])
          @user.password_hash = nil;
          @user.save
          redirect_to root_path, success: t('auth.change_password_success')
        else
          redirect_to auth_change_password_path+"?token="+@token, error: @user.errors.to_json
        end 
      end
    else
      redirect_to root_path, error: t('auth.incorrect_token')
    end
  end
  
  def confirm_email
    token = params[:token]
    users = User.where(registration_hash: token)
    if users.any?
      @user = users.first
      @user.registration_hash = nil
      @user.status = 1
      @user.save
      redirect_to root_path, success: t('auth.activation_success')
    else
      redirect_to root_path, error: t('auth.activation_failure')
    end
  end
  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :accept_statuate)
    end
end
