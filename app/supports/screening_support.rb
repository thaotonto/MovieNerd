class ScreeningSupport
  attr_reader :movie
  attr_reader :room
  attr_reader :date

  def initialize movie, room = nil, date = nil
    room ||= Room.first
    @movie = movie
    @room = room
    @date = date
  end

  def rooms
    Room.all.order_room
  end

  def movie_title
    @movie.title
  end

  def screenings_by_movie
    @movie.screenings.not_show_yet
  end

  def screenings_by_room
    if date.nil?
      @room.screenings.not_show_yet
    else
      @room.screenings.not_show_yet.by_date date
    end
  end
end
