class Admin::SearchsController < Admin::BaseController
  before_action :search_movies

  def index; end

  private

  def search_movies
    @keyword = params[:keyword]
    @movies = if @keyword.nil? || @keyword.empty?
                Movie.page(params[:page]).per Settings.admin.per_page
              else
                Movie.full_text_search(@keyword)
                     .page(params[:page])
                     .per Settings.admin.per_page
              end
  end
end
