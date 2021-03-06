class Order < ApplicationRecord
  acts_as_paranoid
  enum paid: [:paid, :unpaid]
  after_destroy :send_mail, if: :paid?

  belongs_to :user
  belongs_to :screening
  has_many :movie_tickets, dependent: :destroy
  has_many :seats, through: :movie_tickets

  validates :user, presence: true
  validates :screening, presence: true
  validates :paid, presence: true

  def send_mail
    if Rails.env.development?
      OrderDeletedWorker.perform_async id
    else
      UserMailer.order_deleted(self).deliver_now
    end
  end

  def delete_unpaid
    really_destroy! if unpaid?
  end
  handle_asynchronously :delete_unpaid, run_at: proc{5.minutes.from_now}

  def show_seats
    str = []
    seats.each do |seat|
      str.push(" #{I18n.t('seats.row')}#{seat.row}x"\
        "#{I18n.t('seats.number')}#{seat.number} ")
      str.push "||"
    end
    str.pop
    str
  end
end
