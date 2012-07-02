class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: [:destroy]
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "user destroyed."
    redirect_to users_path
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success]="Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    #@microposts = @user.microposts.paginate(page: params[:page])
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
        flash[:error] = "not found"
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

  #def following
  # @title = "Following"
  # @user = User.find(params[:id])
  # @users = @user.followed_users.paginate(page: params[:page])
  # render 'show_follow'
  #end

  #def followers
  # @title = "Followers"
  # @user = User.find(params[:id])
  # @users = @user.followers.paginate(page: params[:page])
  # render 'show_follow'
  #end



  private
  # def signed_in_user
  # store_location
  # # redirect_to signin_path, notice: "Please sign in." unless signed_in?
  # end
  def correct_user
    @user=User.find(params[:id])
    redirect_to root_path unless (current_user?(@user) || current_user.admin?)
  end
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end