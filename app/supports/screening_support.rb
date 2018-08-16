class ScreeningSupport
  attr_reader :movie

  def initialize movie
    @movie = movie
  end

  def rooms
    Room.all
  end

  def movie_title
    @movie.title
  end

  def screenings
    @movie.screenings
  end
end
