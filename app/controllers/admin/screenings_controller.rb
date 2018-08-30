class Admin::ScreeningsController < Admin::BaseController
  before_action :load_support, only: [:new, :edit, :create]

  def index
    @rooms = Room.all
    load_screenings

    respond_to do |format|
      format.html
      format.js{render "admin/screenings/filter_by_date"}
    end
  end

  def new
    @screening = Screening.new
    respond_to do |format|
      format.html
      format.js{render "admin/screenings/filter_screening"}
    end
  end

  def create
    @screening = Screening.new screenings_params
    movie = @screening.movie

    if @screening.save
      redirect_to admin_movie_path movie
    else
      render :new
    end
  end

  def destroy
    @screening = Screening.find_by id: params[:id]
    movie = if params[:movie_id]
              Movie.find_by id: params[:movie_id]
            else
              @screening.movie
            end
    @screening.destroy
    flash[:success] = t "flash.screening_delete_success"
    redirect_to admin_movie_path movie
  end

  private

  def screenings_params
    params.require(:screening).permit :screening_start, :movie_id, :room_id
  end

  def load_support
    date = params[:date].to_date if params[:date]
    room = Room.find_by id: params[:screening][:room_id] if params[:screening]
    @support = ScreeningSupport.new find_movie, room, date

    return if @support.room
    flash[:danger] = t "flash.no_room"
    redirect_to admin_movie_path @support.movie
  end

  def find_movie
    movie = if params[:movie_id]
              Movie.find_by id: params[:movie_id]
            elsif params[:screening]
              Movie.find_by id: params[:screening][:movie_id]
            end

    return movie if movie
    flash[:danger] = t "flash.no_movie"
    redirect_to admin_movies_path
  end

  def load_screenings
    @screenings = if params[:datepick].blank?
                    filter_screening
                  else
                    filter_screening.by_date params[:datepick].to_date
                  end
  end

  def filter_screening
    if params[:id_room].blank?
      Screening.not_show_yet
    else
      room = Room.find_by id: params[:id_room]
      room.screenings.not_show_yet
    end
  end
end
