module SessionsHelper

  def signed_in?
    !current_user.nil?
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: 'Please sign in'
    end
  end

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def sign_out
    @current_user = nil
    session[:cart_id] = nil
    cookies.delete(:remember_token)
  end

  def registered_user
    if signed_in?
      redirect_to root_path
    end
  end

  def admin_user
    redirect_to(signin_path) unless (!current_user.nil? and current_user.admin?)
  end

  #--------------------------------

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def current_user?(user)
    current_user == user
  end

  #--------------------------------

  def current_cart
    cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  #--------------------------------

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.fullpath
  end
end
