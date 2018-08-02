class MovieTicket < ApplicationRecord
  belongs_to :seat
  belongs_to :order
end
