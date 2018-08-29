class ReactivateUserWorker
  include Sidekiq::Worker
  sidekiq_options queue: :mailer

  def perform user_id, token
    user = User.only_deleted.find_by id: user_id
    UserMailer.reactivation_instruction(user, token).deliver_now
  end
end
