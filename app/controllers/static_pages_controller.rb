class StaticPagesController < ApplicationController
  
  def main
    @indices = Index.all
  end
  
end
