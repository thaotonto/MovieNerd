class Admin::BaseController < ApplicationController
  include UsersHelper
  before_action :admin_required

  protected

  def current_ability
    @current_ability ||= AdminAbility.new current_user
  end

  def admin_required
    return if current_user && (current_user.admin? || current_user.mod?)
    redirect_to root_url
  end
end
