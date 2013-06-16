class AccountsController < ApplicationController
  before_filter :signed_in_user

  add_breadcrumb "Accounts", :accounts_path

  def index
    @accounts = Account.paginate(page: params[:page])

    @total = @accounts.total_entries
  end

  def show
    fetch_account

    add_breadcrumb @account.name, @account
  end

  def new
    @account = Account.new

    add_breadcrumb "New", new_account_path
  end

  def create
    @account = Account.new(params[:account])

    add_breadcrumb "New", new_account_path

    if @account.save
      flash[:success] = t(:account_created)
      redirect_to accounts_path
    else
      render 'new'
    end
  end

  def edit
    fetch_account

    add_breadcrumb @account.name, @account
    add_breadcrumb "Edit", edit_account_path(@account)
  end

  def update
    fetch_account

    add_breadcrumb @account.name, @account
    add_breadcrumb "Edit", edit_account_path(@account)

    if @account.update_attributes(params[:account])
      flash[:success] = t(:account_updated)
      redirect_to accounts_path
    else
      render 'edit'
    end
  end

  def destroy
    fetch_account.destroy

    flash[:success] = t(:account_deleted)
    redirect_to accounts_url
  end

  private # ----------------------------------------------------------

  def fetch_account
    @account = Account.find(params[:id])
  end
end
