class Seat < ApplicationRecord
  acts_as_paranoid
  belongs_to :room
  has_many :movie_tickets

  def name
    "#{row}_#{number}"
  end
end
