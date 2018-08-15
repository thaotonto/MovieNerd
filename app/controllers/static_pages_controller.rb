class StaticPagesController < ApplicationController
  def home
    @movies = Movie.page(params[:page])
                   .per Settings.movie.per_page
  end
end
