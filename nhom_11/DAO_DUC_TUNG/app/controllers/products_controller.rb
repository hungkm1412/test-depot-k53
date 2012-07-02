class ProductsController < ApplicationController
  before_filter :admin_user, only: [:edit, :update, :destroy, :new]

  def index
    @products = Product.paginate(page: params[:page])
  end

  def show
    @product = Product.find(params[:id])
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    flash[:success] = "Product destroyed"
    redirect_to products_path
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      flash[:success] = "Product added"
      redirect_to products_path
    else
      render 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      flash[:success] = "Product updated"
      redirect_to products_path
    else
      render 'edit'
    end
  end
end
