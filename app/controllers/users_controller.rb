class UsersController < ApplicationController
  before_action :find_user, only: [:show]
  before_action :correct_user, only: [:show]

  def index
    url = if user_signed_in?
            edit_user_registration_url
          else
            new_user_registration_url
          end
    redirect_to url
  end

  def show
    @orders = @user.orders.page(params[:page]).per Settings.admin.per_page
  end

  private

  def correct_user
    redirect_to root_url unless @user.current_user? current_user
  end
end
