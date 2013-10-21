class HomeController < ApplicationController
  def home
    @indices = Index.all
  end
end
