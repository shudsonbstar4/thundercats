class OrdersController < ApplicationController
before_filter :authenticate_user!

  def index
	@orders = Order.order('id desc')
  end

  def show
  end
end
