class Users::SessionsController < Devise::SessionsController
  def create
    user = User.only_deleted.find_by email: user_params[:email]
    if user
      flash[:danger] = t "flash.deleted_account"
      redirect_to new_reactivation_url
    else
      super
    end
  end

  private

  def user_params
    params.require(:user).permit :email
  end
end
