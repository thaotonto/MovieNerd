class User < ApplicationRecord
  has_many :orders
  has_many :screenings, through: :orders
end
