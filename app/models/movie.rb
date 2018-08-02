class Movie < ApplicationRecord
  has_many :screenings
  has_many :rooms, through: :screenings
end
