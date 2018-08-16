class User < ApplicationRecord
  attr_reader :remember_token, :activation_token, :reset_token
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

  before_save :email_downcase
  before_create :create_activation_digest
  has_secure_password
  scope :order_user, ->{where(activated: true).order created_at: :desc}

  def remember
    @remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password? token
  end

  def forget
    update_attributes remember_digest: nil
  end

  def current_user? user
    self == user
  end

  def activate
    update_attributes activated: true, activated_at: Time.zone.now
  end

  def send_activation_mail
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    @reset_token = User.new_token
    update_attributes reset_digest: User.digest(reset_token),
      reset_sent_at: Time.zone.now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < Settings.password_reset_expired.hours.ago
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

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  private

  def email_downcase
    self.email = email.downcase
  end

  def create_activation_digest
    @activation_token = User.new_token
    self.activation_digest = User.digest activation_token
  end
end
