class UsersController < ApplicationController
  load_and_authorize_resource only: :show, find_by: :slug

  def index
    url = if user_signed_in?
            edit_user_registration_url
          else
            new_user_registration_url
          end
    redirect_to url
  end

  def show
    @orders = @user.orders.paid.page(params[:page]).per Settings.admin.per_page
  end
end
