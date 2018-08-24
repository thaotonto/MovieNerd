class AcceptsController < ApplicationController
  def index
    @order = Order.find_by id: params[:id]
    if @order.present? && @order.user.current_user?(current_user)
      @order.paid!
      redirect_to user_order_url current_user order
    else
      flash[:danger] = t "flash.no_order"
      redirect_to root_url
    end
  end
end
