class OrdersController < ApplicationController

  before_filter :signed_in_user, only: [:new, :create]
  before_filter :admin_user, only: [:destroy, :edit, :index]

  def create
    @order = Order.new(user_id: current_user.id, cart_id: current_cart.id)
    if @order.save
      session[:cart_id] = nil
      flash[:success] = "Order processed"
    else
      flash[:error] = "Order not processed"
    end
    redirect_to root_path
  end

  def index
    @orders = Order.paginate(page: params[:page])
  end

  def new
    @order = Order.new
  end

  def show
    @order = Order.find(params[:id])
    @user = @order.user
  end

end
