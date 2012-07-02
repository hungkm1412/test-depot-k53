class CategoriesController < ApplicationController
  before_filter :admin_user,     only: [:destroy, :edit, :update, :new]

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @products = Product.where("category_id = ?", (params[:id]))
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(params[:category_id])

    if @category.save
     	flash[:success] = 'Category was successfully created.'
      redirect_to categories_path
    else
    	render 'new'
    end
  end

  def update
    @category = Category.find(params[:id])

    if @category.update_attributes(params[:category])
    	flash[:success] = 'Category was successfully updated.'
			redirect_to categories_path
    else
			render 'edit'
		end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
		flash[:success] = 'Category was successfully destroyed'
		redirect_to categories_path
  end

  private
  def admin_user
      redirect_to(root_path) unless current_user.admin?
  end
end
