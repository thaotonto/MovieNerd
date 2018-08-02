class Room < ApplicationRecord
  has_many :seats
  has_many :screenings
  has_many :movies, through: :screenings
end
