class HomeController < ApplicationController
  def index
    redirect_to main_path if user_signed_in?
  end

  def main
    redirect_to root_path unless user_signed_in?
  end

  def wall
   @analysies = current_user.get_analysies_history
  end
end
