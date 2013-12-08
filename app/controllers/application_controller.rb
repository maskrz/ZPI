class ApplicationController < ActionController::Base
  include AuthHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  add_flash_types :error, :notice, :alert, :success
  
  before_action :check_for_login_cookie
  
  def authenticate
    AuthHelper.auth(params)
  end
  
  def check_for_login_cookie
    user_sign_in get_login_cookie if login_cookie_set?
  end
end
