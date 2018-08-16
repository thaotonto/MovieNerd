class Movie < ApplicationRecord
  enum rated: [:G, :PG, :PG13, :R, :NC17]
  include PgSearch

  has_many :screenings, dependent: :destroy
  has_many :rooms, through: :screenings
  mount_uploader :picture, PictureUploader
  validates :title, presence: true,
    length: {maximum: Settings.title_max_length},
    uniqueness: {case_sensitive: false}
  validates :director, presence: true
  validates :cast, presence: true
  validates :description, presence: true
  validates :language, presence: true
  validates :genre, presence: true
  validates :release_date, presence: true
  validates :rated, presence: true
  validates :duration, presence: true
  validates :picture, presence: true
  validate :release_date_cannot_be_in_the_past
  validate :time_duration
  validate :picture_size
  scope :with_title, ->(title){where "LOWER(title) like ?", "%#{title}%"}
  scope :home_movie, ->{order release_date: :desc}
  pg_search_scope :full_text_search,
    against: {
      title: "A",
      director: "B",
      description: "C"
    }
  before_save :beatify

  private
  def beatify
    self.title = title.titleize
    self.director = director.titleize
    self.cast = cast.titleize
    self.genre = genre.titleize
    self.description = description.upcase_first
  end

  def release_date_cannot_be_in_the_past
    return unless release_date.present? && release_date < Date.today
    errors.add :release_date,
      I18n.t("activerecord.errors.models.movie.attributes.release_date.invalid")
  end

  def time_duration
    return unless duration.present? && duration <= 0
    errors.add :duration,
      I18n.t("activerecord.errors.models.movie.attributes.duration.invalid")
  end

  def picture_size
    return if picture.size < Settings.movie.picture_size.megabytes
    errors.add :picture, I18n.t("movie.picture_size_error")
  end
end
