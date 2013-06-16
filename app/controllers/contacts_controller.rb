class ContactsController < ApplicationController
  before_filter :signed_in_user

  add_breadcrumb "Contacts", :contacts_path

  def index
    @contacts = Contact.paginate(page: params[:page])

    @total = @contacts.total_entries
  end

  def show
    fetch_contact

    add_breadcrumb @contact.name, @contact
  end

  def new
    @contact = Contact.new

    add_breadcrumb "New", new_contact_path
  end

  def create
    @contact = Contact.new(params[:contact])

    add_breadcrumb "New", new_contact_path

    if @contact.save
      flash[:success] = t(:contact_created)
      redirect_to contacts_path
    else
      render 'new'
    end
  end

  def edit
    fetch_contact

    add_breadcrumb @contact.name, @contact
    add_breadcrumb "Edit", edit_contact_path(@contact)
  end

  def update
    fetch_contact

    add_breadcrumb @contact.name, @contact
    add_breadcrumb "Edit", edit_contact_path(@contact)

    if @contact.update_attributes(params[:contact])
      flash[:success] = t(:contact_updated)
      redirect_to contacts_path
    else
      render 'edit'
    end
  end

  def destroy
    fetch_contact.destroy

    flash[:success] = t(:contact_deleted)
    redirect_to contacts_url
  end

  private # ----------------------------------------------------------

  def fetch_contact
    @contact = Contact.find(params[:id])
  end
end
