class Admin::ScreeningsController < Admin::BaseController
  before_action :load_support, only: [:new, :edit, :create]

  def index
    @screening = Screening.page(params[:page])
                          .per Settings.admin.per_page
  end

  def new
    @screening = Screening.new
  end

  def create
    @screening = Screening.new screenings_params

    if @screening.save
      redirect_to admin_movies_path
    else
      render :new
    end
  end

  def update
    if @screening.update_attributes screenings_params
      flash[:success] = t "flash.screening_update_success"
      redirect_to admin_movies_path
    else
      render :edit
    end
  end

  def destroy
    @screening.destroy
    flash[:success] = t "flash.screening_delete_success"
    redirect_to admin_movies_path
  end

  private

  def screenings_params
    params.require(:screening).permit :screening_start, :movie_id, :room_id
  end

  def load_support
    @support = ScreeningSupport.new find_movie
  end

  def find_movie
    movie = if params[:movie_id]
              Movie.find_by id: params[:movie_id]
            else
              Movie.find_by id: screenings_params[:movie_id]
            end

    return movie if movie
    flash[:danger] = t "flash.no_movie"
    redirect_to admin_movies_path
  end
end
