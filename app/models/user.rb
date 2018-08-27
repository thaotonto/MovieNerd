class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :validatable
  enum user_type: [:member, :admin, :mod]
  enum blocked: [:block, :unblock]
  has_many :orders
  has_many :screenings, through: :orders
  VALID_EMAIL_REGEX = /\A[\w.\-]+@[a-z+\d\-.]+\.+[a-z]+\z/i

  validates :name, presence: true, length: {maximum: Settings.name_max_length}
  validates :email, presence: true,
    length: {maximum: Settings.email_max_length},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, allow_nil: true,
    length: {minimum: Settings.pass_min_length}
  scope :order_user, ->{order created_at: :desc}

  def current_user? user
    self == user
  end

  def block_check string1, string2
    if block?
      string1
    else
      string2
    end
  end

  def mod_check string1, string2
    if mod?
      string1
    else
      string2
    end
  end

  def handle type
    if type == 1
      block_check Settings.admin.unblock, Settings.admin.block
    elsif type == 2
      block_check "admin.users.unblock", "admin.users.block"
    elsif type == 3
      block_check "btn btn-success", "btn btn-danger"
    elsif type == 4
      mod_check Settings.admin.member, Settings.admin.mod
    elsif type == 5
      mod_check "admin.users.member", "admin.users.mod"
    else
      mod_check "btn btn-danger", "btn btn-success"
    end
  end
end
