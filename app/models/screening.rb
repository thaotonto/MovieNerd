class Screening < ApplicationRecord
  belongs_to :movie
  belongs_to :room
  has_many :orders
  has_many :users, through: :orders
end
