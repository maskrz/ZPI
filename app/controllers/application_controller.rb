class ApplicationController < ActionController::Base
  include AuthHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  add_flash_types :error, :notice, :alert, :success
  
  def authenticate
    AuthHelper.auth(params)
  end
end
