class CategoriesController < ApplicationController

  before_filter :signed_in_user
    before_filter :admin_user, only: [:destroy, :update, :edit]


  def index
    @categories = Category.paginate(page: params[:page])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      redirect_to @category
    else

    end
  end

  def show
    @category = Category.find(params[:id])
    @products = @category.products.paginate(page: params[:page])
    remember_category(@category)
    # render 'show'
  end

  def update
    @category=Category.find(params[:id])
    if @category.update_attributes(params[:category])
      flash[:success]="Updated."
      redirect_to @category
    else
      render 'edit'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = "Category destroyed."
    redirect_to categories_path
  end
  private

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end
