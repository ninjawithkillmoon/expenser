module SessionsHelper

  def sign_in(p_user)
    cookies.permanent[:remember_token] = p_user.remember_token
    self.current_user = p_user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(p_user)
    @current_user = p_user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def current_user?(p_user)
    p_user == current_user
  end

  def redirect_back_or(p_default)
    redirect_to(session[:return_to] || p_default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end

  def admin?
    return signed_in? && current_user.admin?
  end

  def admin_user
    unless admin?
      flash[:error] = t(:not_authorized)
      redirect_to root_path
    end
  end

  def signed_in_user
    unless signed_in?
      store_location
      flash[:notice] = t(:sign_in_first)
      redirect_to signin_url
    end
  end

  def signed_out_user
    if signed_in?
      flash[:notice] = t(:sign_out_first)
      redirect_to root_path
    end
  end

end
