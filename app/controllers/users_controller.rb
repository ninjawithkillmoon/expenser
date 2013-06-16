class UsersController < ApplicationController
  before_filter :signed_in_user

  def show
    fetch_user

    add_breadcrumb @user.name, @user
  end

  def edit
    fetch_user

    add_breadcrumb @user.name, @user
    add_breadcrumb "Edit", edit_user_path(@user)
  end

  def update
    fetch_user

    add_breadcrumb @user.name, @user
    add_breadcrumb "Edit", edit_user_path(@user)

    if @user.update_attributes(params[:user])
      flash[:success] = t(:profile_updated)
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  private # ---------------------------------------------------------------------------

  def fetch_user
    @user = User.find(params[:id])
  end
end
