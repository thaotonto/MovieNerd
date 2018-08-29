class Admin::AffectedOrdersController < ApplicationController
  def index
    @orders = Order.with_deleted.where id: params[:orders_id]
  end
end
