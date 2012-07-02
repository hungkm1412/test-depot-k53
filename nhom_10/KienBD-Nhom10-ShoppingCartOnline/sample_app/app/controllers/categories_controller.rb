class CategoriesController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user ,only: [:edit,:destroy,:create,:new]
  def show
    @category = Category.find(params[:id])
    @products = @category.products.paginate(page: params[:page])
    @product = Product.new
  end
  def search
    @category = Category.find_by_name(params[:name])
    render 'show'
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @category
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      flash[:success] = "Profile updated"
      sign_in current_user
      redirect_to @category
    else
      render 'edit'
    end
  end

  def index
    @categories = Category.paginate(page: params[:page])
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = "category destroyed."
    redirect_to categories_path
  end
  private
  def admin_user
    redirect_to (root_path) unless current_user.admin?
  end
end

