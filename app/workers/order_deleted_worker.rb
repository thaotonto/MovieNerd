class OrderDeletedWorker
  include Sidekiq::Worker
  sidekiq_options queue: :mailer

  def perform order_id
    order = Order.find_by id: order_id
    UserMailer.order_deleted(order).deliver_now
  end
end
