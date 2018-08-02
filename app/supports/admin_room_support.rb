class AdminRoomSupport
  attr_accessor :row_num, :max_seat_per_row, :deleted_seats, :room, :map

  def initialize room, row_num, max_seat_per_row, deleted_seats, map
    @room = room
    @row_num = row_num
    @max_seat_per_row = max_seat_per_row
    @deleted_seats = deleted_seats
    @map = map
  end
end
