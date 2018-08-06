class Seat < ApplicationRecord
  belongs_to :room
  has_many :movie_tickets
end
