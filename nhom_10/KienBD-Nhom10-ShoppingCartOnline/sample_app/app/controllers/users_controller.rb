class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:destroy,:edit, :update, :index]
  before_filter :admin_user,     only: [:edit,:destroy,:update]
  def show
    @user = User.find(params[:id])
    # @microposts = @user.microposts.paginate(page: params[:page])
    # @products = @user.products.paginate(page: params[:page])
  end
  def search
    @user = User.find_by_name(params[:name])
    render 'show'
  end

  def find
    @user = User.find_by_email(params[:email])
    if !@user.nil?
      render 'show'
    else
      @user = User.find_by_name(params[:email])
      if !@user.nil?
        render 'show'
      else
        flash[:error] = "Not found"
        redirect_to root_path
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in current_user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
  def admin_user
    redirect_to (root_path) unless current_user.admin?
  end
end
