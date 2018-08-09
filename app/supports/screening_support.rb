class ScreeningSupport
  attr_reader :movie

  def initialize movie
    @movie = movie
  end

  def rooms
    Room.all
  end
end
