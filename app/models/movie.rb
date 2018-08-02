class Movie < ApplicationRecord
  has_many :screenings
  has_many :rooms, through: :screenings

  validates :title, presence: true, length: {maximum: Settings.title_max_length}

  scope :with_title, ->(title){where "LOWER(title) like ?", "%#{title}%"}
end
