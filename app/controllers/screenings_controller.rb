class ScreeningsController < ApplicationController
  before_action :load_support, only: [:index]

  def index; end

  private

  def load_support
    movie = Movie.friendly.find_by slug: params[:id]
    @support = ScreeningSupport.new movie
  end
end
