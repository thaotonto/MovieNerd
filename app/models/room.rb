class Room < ApplicationRecord
  has_many :seats
  has_many :screenings
  has_many :movies, through: :screenings

  def map
    set_chair row_num, max_seat_per_row
  end

  def row_num
    seats.map(&:row).uniq.max
  end

  def max_seat_per_row
    seats.map(&:number).uniq.max
  end

  private

  def set_chair row_num, max_seat_per_row
    map = Array.new(row_num){"_" * max_seat_per_row}
    seats.each do |seat|
      map[seat.row - 1][seat.number - 1] = "a"
    end
    map
  end
end
