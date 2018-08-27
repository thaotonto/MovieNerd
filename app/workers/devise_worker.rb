class DeviseWorker
  include Sidekiq::Worker
  sidekiq_options queue: :mailer

  def perform method, user_id, *args
    user = User.find_by id: user_id
    Devise.mailer.send(method, user, *args).deliver_now
  end
end
