class Admin::UsersController < Admin::BaseController
  before_action :find_user, only: :update

  def index
    @user = User.order_user.page(params[:page])
                .per Settings.admin.per_page
  end

  def update
    respond_to do |format|
      case params[:type]
      when "block"
        @user&.block!
        format.js{render "admin/users/unblock"}
      when "unblock"
        @user&.unblock!
        format.js{render "admin/users/block"}
      else
        format.html
      end
    end
  end
end
