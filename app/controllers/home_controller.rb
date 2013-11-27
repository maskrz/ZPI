class HomeController < ApplicationController
  def index
    redirect_to wall_path if user_signed_in?
  end

  def main
    redirect_to root_path unless user_signed_in?
  end

  def wall
    redirect_to root_path unless user_signed_in?
    @analysis = current_user.get_analysies_history
    #render json: @analysis
  end
end
