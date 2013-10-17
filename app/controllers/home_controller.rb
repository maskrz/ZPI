class HomeController < ApplicationController
  def index
    @indices = Index.all
  end
end
