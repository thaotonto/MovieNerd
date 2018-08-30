class ReactivationsController < ApplicationController
  before_action :find_user, :valid_user, :check_expiration, only: [:show]

  def new; end

  def create
    @user = User.only_deleted.find_by email:
      params[:reactivate][:email].downcase
    if @user
      @user.create_reactive_digest
      @user.send_reactive_email
      flash[:info] = t "reactivate_mail.send_instructions"
      redirect_to root_url
    else
      flash.now[:danger] = t "forgot_password.not_found"
      render :new
    end
  end

  def show
    if @user.reactivated? params[:id]
      @user.restore recursive: true
      flash[:success] = t "reactivate_mail.success"
      redirect_to root_url
    else
      flash[:danger] = t "reactivate_mail.fail"
      redirect_to new_reactivation_url
    end
  end

  private

  def find_user
    @user = User.with_deleted.find_by email: params[:email]

    return if @user
    flash[:danger] = t "flash.cannot_find_user"
    redirect_to root_url
  end

  def valid_user
    return if @user&.deleted?
    flash[:alert] = t "reactivate_mail.already_confirmed"
    redirect_to root_url
  end

  def check_expiration
    return unless @user.reactivate_expired?
    flash[:danger] = t "reactivate_mail.expired"
    redirect_to new_reactivation_url
  end
end
