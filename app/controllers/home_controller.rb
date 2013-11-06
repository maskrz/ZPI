class HomeController < ApplicationController
  def index
    redirect_to '/home/main' if signed_in?
  end

  def main
    redirect_to root_path unless signed_in?
  end

end
