class HomeController < ApplicationController
    
  def main
    @indices = Index.all
  end
  
end
