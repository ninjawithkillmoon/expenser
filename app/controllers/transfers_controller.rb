class TransfersController < ApplicationController
  before_filter :signed_in_user

  add_breadcrumb "Transactions", :transactions_path

  def new
    @transfer = Transfer.new
    fetch_all_for_form

    add_breadcrumb "New", new_transfer_path + '#transfer'

    render 'transactions/new'
  end

  def create
    @transfer = Transfer.new(params[:transfer])
    @transaction = Transaction.new
    fetch_all_for_form

    add_breadcrumb "New", new_transfer_path + '#transfer'

    if @transfer.valid?
      flash[:success] = t(:transfer_created)
      redirect_to transactions_path
    else
      render 'transactions/new'
    end
  end

  private #-----------------------------------------------

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
    @transactions_with_contact = Transaction.where('contact_id IS NOT NULL')
  end

  def fetch_tags
    @tags = Tag.all
  end
end