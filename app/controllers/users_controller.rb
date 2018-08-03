class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_mail
      flash[:success] = t "activate_mail.noti"
      redirect_to root_url
    else
      render :new
    end
  end

  def show
    redirect_to root_url unless @user.activated?
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "flash.updated"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "flash.pls_log_in"
    redirect_to login_url
  end

  def correct_user
    redirect_to root_url unless @user.current_user? current_user
  end
end
