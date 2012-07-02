class CartsController < ApplicationController
  include SessionsHelper
  
  def index
    @cart = Cart.new
    if signed_in?
      @allcarts = Cart.all
      @carts = Cart.paginate(page: params[:page])
    else
      redirect_to root_path
    end
  end

  def new
    @cart = Cart.new
  end

  def create
    @cart = Cart.new(user_id: params[:user_id],product_id: params[:product_id], number: params[:number])
    if @cart.save
      flash[:success] = "Created Successfully"
      redirect_to shop_path
    else
      flash[:error] = "Add cart Failed"
      redirect_to product_path(params[:product_id])
    end
  end

  def destroy
    Cart.find(params[:id]).destroy
    flash[:success] = "Cart destroyed"
    redirect_to carts_path
  end

end
