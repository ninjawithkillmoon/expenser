class TransactionsController < ApplicationController
  before_filter :signed_in_user

  add_breadcrumb "Transactions", :transactions_path

  def index
    @transactions = Transaction.paginate(page: params[:page])

    @total = @transactions.total_entries
  end

  def show
    fetch_transaction

    add_breadcrumb 'Transaction', @transaction
  end

  def new
    @transaction = Transaction.new

    add_breadcrumb "New", new_transaction_path
  end

  def create
    @transaction = Transaction.new(params[:transaction])

    add_breadcrumb "New", new_transaction_path

    if @transaction.save
      flash[:success] = t(:transaction_created)
      redirect_to transactions_path
    else
      render 'new'
    end
  end

  def edit
    fetch_transaction

    add_breadcrumb 'Transaction', @transaction
    add_breadcrumb "Edit", edit_transaction_path(@transaction)
  end

  def update
    fetch_transaction

    add_breadcrumb 'Transaction', @transaction
    add_breadcrumb "Edit", edit_transaction_path(@transaction)

    if @transaction.update_attributes(params[:transaction])
      flash[:success] = t(:transaction_updated)
      redirect_to transactions_path
    else
      render 'edit'
    end
  end

  def destroy
    fetch_transaction.destroy

    flash[:success] = t(:transaction_deleted)
    redirect_to transactions_url
  end

  private # ----------------------------------------------------------

  def fetch_transaction
    @transaction = Transaction.find(params[:id])
  end
end
