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
    pass_changed = false
    any_changes = false

    @user = current_user

    if params[:update]
      
      if (@user.first_name != params[:user][:first_name])
        any_changes = true
      end
      if (@user.last_name != params[:user][:last_name])
        any_changes = true
      end
      
      if !params[:user][:password].blank?
        @user.password = params[:user][:password]
        @user.password_confirmation = params[:user][:password_confirmation]
      pass_changed = true
      end
      if params[:user][:delete_avatar] == '1'
      @user.avatar.destroy
      else
        unless params[:user][:avatar].blank?
          any_changes = true
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
        if pass_changed
          @user.password = @user.password_confirmation = Digest::MD5.hexdigest(params[:user][:password])
          @user.save
          redirect_to '/home/user_edit', success: t('auth.change_password_success')
        else
          if(!any_changes)
            redirect_to '/home/user_edit', notice: t('home.user_edit.no_changes')
          else
            @user.save
            redirect_to '/home/user_edit', success: t('home.user_edit.datas_saved')
          end
        end
      else
        redirect_to '/home/user_edit', error: @user.errors.values.join('<br>').html_safe
      end
    end
  end
end
