class Admin::MoviesController < Admin::BaseController
  def index
    @movies = Movie.page(params[:page])
                   .per Settings.admin.per_page
  end
end
