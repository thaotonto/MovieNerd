class Order < ApplicationRecord
  belongs_to :user
  belongs_to :screening
  has_many :movie_tickets
  has_many :seats, through: :movie_tickets
end
