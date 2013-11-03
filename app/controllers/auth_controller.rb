class AuthController < ApplicationController
  require 'digest/md5'
  def login    
    redirect_to root_path, error: ["Test error", "Test error"]
  end
  
  def logout
    
  end
  
  def register
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        
        UserMailer.after_sign_up(@user).deliver
        
        format.html { render json: @user }
      else
        format.html { render json: { status: "failure", errors: @user.errors } }
      end
    end
  end
  
  def forgot_password
  end
  
  def confirm_email
    token = params[:token]
    user = User.where(registration_hash: token)
    render json: user
  end
  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :accept_statuate)
    end
end
