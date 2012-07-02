class ProductsController < ApplicationController
  before_filter :admin_user, only: [:create, :destroy, :update, :edit]
  # before_filter :correct_product,   only: [:edit, :update]

  def show
    @product = Product.find(params[:id])
    # @products = @product.paginate(page: params[:page])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    if @product.save 
      flash[:success] = "Product Created!"
      redirect_to @product
    else
      render 'new'
    end
  end

  def index
    @products = Product.paginate(page: params[:page])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      flash[:success] = "Product updated"
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:success] = "Product destroyed."
    redirect_to products_path
  end

  private
  def admin_user
    if (current_user.nil?)
      redirect_to(root_path)
    else
      redirect_to(root_path) unless current_user.admin?
    end
  end
end
