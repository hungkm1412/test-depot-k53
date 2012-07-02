class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:edit, :update, :index, :destroy]
  before_filter :registered_user, only: [:new, :create]
  before_filter :admin_user, only: [:destroy, :edit]

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Shop!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    unless user.admin?
      user.destroy
      flash[:success] = "User destroyed"
    else
      flash[:error] = "Cannot delete admin account"
    end
    redirect_to users_path
  end
end
