class UserMailer < ApplicationMailer
  def reactivation_instruction user, token = nil
    @user = user
    @token = if token
               token
             else
               @user.reactivate_token
             end
    mail to: user.email, subject: t("reactivate_mail.title")
  end

  def order_deleted order
    @order = order
    mail to: order.user.email, subject: t("order_deleted.title")
  end
end
