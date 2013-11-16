class HomeController < ApplicationController
  def index
    redirect_to '/home/main' if user_signed_in?
  end

  def main
    redirect_to root_path unless user_signed_in?
  end

end
