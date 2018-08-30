class Users::RegistrationsController < Devise::RegistrationsController
  def create
    user = User.only_deleted.find_by email: user_params[:email]
    if user
      flash[:danger] = t "flash.user_exists"
      redirect_to root_url
    else
      super
    end
  end

  def destroy
    resource.soft_delete
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed
    yield resource if block_given?
    respond_with_navigational resource do
      redirect_to after_sign_out_path_for resource_name
    end
  end

  private

  def user_params
    params.require(:user).permit :email
  end
end
