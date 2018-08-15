class MoviesController < ApplicationController
  def show
    @movie = Movie.find_by id: params[:id]

    return if @movie
    flash[:danger] = t "flash.no_movie"
    redirect_to root_url
  end
end
