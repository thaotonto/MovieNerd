class Admin::UsersController < Admin::BaseController
  load_and_authorize_resource find_by: :slug

  def index
    @users = User.order_user.page(params[:page])
                 .per Settings.admin.per_page
  end

  def show; end

  def update
    respond_to do |format|
      case params[:type]
      when "block"
        @user&.block!
        format.js{render "admin/users/unblock"}
      when "unblock"
        @user&.unblock!
        format.js{render "admin/users/block"}
      when "mod"
        @user&.mod!
        format.js{render "admin/users/degrade"}
      when "member"
        @user&.member!
        format.js{render "admin/users/upgrade"}
      else
        format.html
      end
    end
  end
end
