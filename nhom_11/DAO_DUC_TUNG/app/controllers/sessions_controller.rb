class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by_email(params[:email])
    if !user.nil? and user.authenticate(params[:password])
      sign_in user
      redirect_back_or root_path
    else
      flash.now[:error] = "Invalid login login information"
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
