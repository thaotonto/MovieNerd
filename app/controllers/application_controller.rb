class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:name]
    devise_parameter_sanitizer.permit :account_update, keys: [:name]
  end

  private

  def logged_in_user
    return if user_signed_in?
    store_location
    flash[:danger] = t "flash.pls_log_in"
    redirect_to login_url
  end

  def find_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = t "flash.no_user"
    redirect_to root_url
  end
end
