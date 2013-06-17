class SessionsController < ApplicationController
  def new
    render layout: 'login'
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)

    if(user && user.authenticate(params[:session][:password]))
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = t(:invalid_login)
      render 'new', layout: 'login'
    end
  end

  def destroy
    sign_out
    flash[:notice] = t(:signed_out)
    redirect_to login_path
  end
end
