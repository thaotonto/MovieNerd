class SearchsController < ApplicationController
  def index
    @movies = Movie.all
  end

  def create
    @movies = Movie.with_title params[:movie][:title].downcase
    render "searchs/index"
  end
end
