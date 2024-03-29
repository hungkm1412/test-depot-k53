class UsersController < ApplicationController
  before_filter :admin_user,     only: [:destroy, :edit, :update]

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
  		flash[:success] = 'Welcome to Practise app'
  		sign_in @user
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def show
  	@user = User.find(params[:id])
  end

  def index
  	@users = User.paginate(page: params[:page])
  end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User destroyed."
		redirect_to users_path
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
    if @user.update_attributes(params[:user])
    	flash[:success] = "Profile updated"
			redirect_to users_path
    else
    	render 'edit'
    end
	end

  private
  def signed_in_user
  	redirect_to signin_path, notice: "Please sign in."
  end

  def admin_user
      redirect_to(root_path) unless current_user.admin?
  end
end
