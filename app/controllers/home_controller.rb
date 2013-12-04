class HomeController < ApplicationController
  def index
    if user_signed_in?
      if current_user.has_analysis?
        redirect_to wall_path
      else
        redirect_to main_path
      end
    end
  end

  def main
    redirect_to root_path unless user_signed_in?
  end

  def wall
    redirect_to root_path unless user_signed_in?
    @analysis = current_user.get_analysies_history
    #render json: @analysis
  end
  
  def user_edit
    require 'digest/md5'
    require 'open-uri'
    
    @user = current_user
    if params[:update]
      unless params[:user][:password].blank?
        @user.password = params[:user][:password]
        @user.password_confirmation = params[:user][:password_confirmation]
      end
      if params[:user][:delete_avatar] == '1'
        @user.avatar.destroy
      else
        unless params[:user][:avatar].blank?
          if params[:user][:avatar].instance_of?(String)
            avatar_url = params[:user][:avatar]
            @user.avatar = open(URI.parse(avatar_url))
          else
            @user.avatar = params[:user][:avatar]
          end
        end
      end
      
      @user.first_name = params[:user][:first_name]
      @user.last_name = params[:user][:last_name]
      
      if @user.valid?
        @user.password = @user.password_confirmation = Digest::MD5.hexdigest(params[:user][:password])
        @user.save
        redirect_to '/home/user_edit', success: 'Zapisano zmiany!'
      else
        render json: params[:user][:avatar]
      end 
    end
  end
end
