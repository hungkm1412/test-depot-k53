class CategoriesController < ApplicationController
  include SessionsHelper

  before_filter :admin_user, only: [:edit,:update, :destroy]

  def index
    if current_user.admin?
      @allcategories = Category.all
      @categories = Category.paginate(page: params[:page])
    else
      redirect_to root_path
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:success] = "Created Successfully"
      redirect_to categories_path
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
      flash[:success] = "Category updated"
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = "User destroyed"
    redirect_to categories_path
  end

  private

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end
