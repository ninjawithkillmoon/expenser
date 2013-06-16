class UsersController < ApplicationController
  before_filter :signed_in_user,      only: [:edit, :update]
  before_filter :user_is_current,     only: [:edit, :update]

  add_breadcrumb "Users", :users_path, only: [:show, :edit, :update]

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

  # Checks that the current signed in user is the same as the one being operated on (from params).
  #
  # Redirects to root with an error message if not, otherwise: continue the operation.
  #
  def user_is_current
    fetch_user

    unless current_user?(@user)
      flash[:error] = t(:not_authorized)
      redirect_to root_path
    end
  end

  def user_is_not_current
    fetch_user

    if current_user?(@user)
      flash[:error] = t(:not_authorized)
      redirect_to @user
    end
  end
end
