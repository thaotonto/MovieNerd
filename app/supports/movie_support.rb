class MovieSupport
  attr_reader :screenings

  def initialize screenings
    @screenings = screenings
  end

  def rooms
    Room.all.order_room
  end
end
