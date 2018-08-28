class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def index
    auth = request.env["omniauth.auth"]
    @user = User.from_omniauth auth

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      if is_navigational_format?
        set_flash_message :notice, :success, kind: auth.provider
      end
    else
      session["devise.omniauth_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end

  alias facebook index
end
