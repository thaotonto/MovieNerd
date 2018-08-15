class Admin::BaseController < ApplicationController
  layout "admin/index"
  include UsersHelper
  include SessionsHelper
  before_action :admin_required

  protected

  def admin_required
    return if current_user&.admin?
    redirect_to root_url
  end
end
