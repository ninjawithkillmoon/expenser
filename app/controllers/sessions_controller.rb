class SessionsController < ApplicationController
  def new
    add_breadcrumb "Sign In", signin_path
  end

  def create
    add_breadcrumb "Sign In", signin_path
    
    user = User.find_by_email(params[:session][:email].downcase)

    if(user && user.authenticate(params[:session][:password]))
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = t(:invalid_login)
      render 'new'
    end
  end

  def destroy
    sign_out
    flash[:notice] = t(:signed_out)
    redirect_to root_path
  end
end
