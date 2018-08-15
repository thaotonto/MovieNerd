class Screening < ApplicationRecord
  belongs_to :movie
  belongs_to :room
  has_many :orders
  has_many :users, through: :orders

  validates :room, presence: true
  validates :movie, presence: true
  validates :screening_start, presence: true
  validate :show_time

  def sold_seats
    sold = []
    orders.each do |order|
      order.seats.each do |seat|
        sold << seat.name
      end
    end
    sold
  end

  private

  def show_time
    return unless screening_start.presence
    return if compare
    errors.add :screening_start,
      I18n.t("activerecord.errors.models.screening.attributes"\
        ".screening_start.invalid")
  end

  def compare
    room.screenings.each do |screening|
      next unless screening.screening_start <= screening_start &&
                  screening_start <= screening.screening_start +
                                     screening.movie.duration.minutes +
                                     Settings.admin.break_time.minutes
      return false
    end
    true
  end
end
