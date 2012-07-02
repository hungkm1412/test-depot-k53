class ProductsController < ApplicationController
  before_filter :admin_user,     only: [:destroy, :edit, :update, :new]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
  	category = Category.find(params[:product][:category_id])
    @product = category.products.build(params[:product])

    if @product.save
   	  flash[:success] = 'Product was successfully created.'
   	  redirect_to products_path
    else
			render 'new'
    end
  end

  def update
    @product = Product.find(params[:id])

    if @product.update_attributes(params[:product])
   		flash[:success] = 'Product was successfully updated.'
   		redirect_to products_path
    else
    	render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
		flash[:success] = 'Product was successfully destroyed'
		redirect_to products_path
  end

  private
  def admin_user
      redirect_to(root_path) unless current_user.admin?
  end
end
