class UsersController < ApplicationController
  before_action :find_user, only: [:show]

  def show; end
end
