class CategoriesController < ApplicationController
  before_filter :admin_user, only: [:create, :destroy, :edit]

  def show
    @category = Category.find(params[:id])
    @products = @category.products.paginate(page: params[:page])
  end

  def index
    @categories = Category.paginate(page: params[:page])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:success] = "Category added"
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = "Category deleted"
    redirect_to categories_path
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      flash[:success] = "Category updated"
      redirect_to categories_path
    else
      render 'edit'
    end
  end
end

