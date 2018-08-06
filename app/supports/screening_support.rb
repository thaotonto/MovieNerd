class ScreeningSupport
  attr_reader :movie
  attr_accessor :room

  def initialize movie, room = nil
    room ||= Room.first
    @movie = movie
    self.room = room
  end

  def rooms
    Room.all
  end

  def movie_title
    @movie.title
  end

  def screenings_by_movie
    @movie.screenings
  end

  def screenings_by_room
    @room.screenings.not_show_yet
  end
end
