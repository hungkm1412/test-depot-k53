class ProductsController < ApplicationController

  before_filter :admin_user, only: [:new, :create, :edit,:update, :destroy]

  def index
    if current_user.admin?
      @allproducts = Product.all
      @products = Product.paginate(page: params[:page])
    else
      redirect_to root_path
    end
  end

  def show
    @product = Product.find(params[:id])
    @category = Category.find(@product.category_id)
    # 
    @cart = Cart.new#(user: current_user,product: @product)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      flash[:success] = "Created Successfully"
      redirect_to products_path
    else
      flash[:error] = "Add cart Failed"
      redirect_to new_product_path
    end
  end

  def destroy
    Product.find(params[:id]).destroy
    flash[:success] = "Product destroyed"
    redirect_to categories_path
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
