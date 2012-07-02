class CartItemsController < ApplicationController

  before_filter :signed_in_user

  def index
    redirect_to products_path
  end

  def create
    cart_item = CartItem.create(product_id: params[:product_id],
                                cart_id: params[:cart_id],
                                quantity: params[:quantity])
    cart_item.save
    redirect_to products_path
  end

  def destroy
    item = CartItem.find(params[:id])
    order = item.cart.order
    item.destroy
    flash[:success] = "Item removed"
    redirect_to order_path(order)
  end
end
