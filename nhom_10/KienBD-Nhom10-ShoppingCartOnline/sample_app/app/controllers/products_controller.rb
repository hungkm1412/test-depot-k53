class ProductsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user, only: [:edit,:create]

  def new
    @product = Product.new
  end

  def show
    @product = Product.find(params[:id])
  end

  def index
    @products = Product.paginate(page: params[:page])
  end
  def create
    @product = Product.new(params[:product])
    if @product.save
      flash[:success] = "Product created!"
      redirect_to products_path
    else
      render 'products/new'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    flash[:success] = "Delete successfully"
    @product.destroy
    redirect_to categories_path
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      flash[:success] = "Profile updated"
      redirect_to categories_path
    else
      render 'edit'
    end
  end
  private
  def admin_user
    redirect_to (root_path) unless current_user.admin?
  end
end
