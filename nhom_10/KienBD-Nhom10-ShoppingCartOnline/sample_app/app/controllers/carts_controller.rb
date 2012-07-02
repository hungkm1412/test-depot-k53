class CartController < ApplicationController
  def show
    @cart = Cart.find(params[:id])
    @items = @cart.items.paginate(page: params[:page])
    @item = Product.new
  end

  def new
    @cart = Cart.new
  end

  def create
    @cart = Cart.new
  end

  def index
    @cart = Cart.paginate(page: params[:page])
  end

  def destroy
    Cart.find(params[:id]).destroy
    flash[:success] = "cart destroyed."
    redirect_to categories_path
  end
end

