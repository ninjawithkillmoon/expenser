class TransactionsController < ApplicationController
  before_filter :signed_in_user

  add_breadcrumb "Transactions", :transactions_path

  def index
    fetch_transactions

    @total = @transactions.total_entries
  end

  def show
    fetch_transaction

    add_breadcrumb 'Transaction', @transaction
  end

  def new
    @transaction = Transaction.new
    @transfer = Transfer.new
    fetch_all_for_form

    add_breadcrumb "New", new_transaction_path
  end

  def create
    @transaction = Transaction.new(params[:transaction])
    fetch_all_for_form

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
    fetch_all_for_form

    add_breadcrumb 'Transaction', @transaction
    add_breadcrumb "Edit", edit_transaction_path(@transaction)
  end

  def update
    fetch_transaction
    fetch_all_for_form

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

  def fetch_transactions
    @transactions = Transaction.order('date DESC').paginate(page: params[:page])
  end

  def fetch_all_for_form
    fetch_accounts
    fetch_contacts
    fetch_transactions_settlement
    fetch_tags
  end

  def fetch_accounts
    @accounts = Account.all
  end

  def fetch_contacts
    @contacts = Contact.all
  end

  def fetch_transactions_settlement
    @transactions_with_contact = Transaction.where('contact_id not null')
  end

  def fetch_tags
    @tags = Tag.all
  end
end
