class TagsController < ApplicationController
  before_filter :signed_in_user

  add_breadcrumb "Tags", :tags_path

  def index
    fetch_tags
  end

  def new
    @tag = Tag.new

    add_breadcrumb "New", new_tag_path
  end

  def create
    @tag = Tag.new(params[:tag])

    add_breadcrumb "New", new_tag_path

    if @tag.save
      flash[:success] = t(:tag_created)
      redirect_to tags_path
    else
      render 'new'
    end
  end

  def edit
    fetch_tag

    add_breadcrumb @tag.name, edit_tag_path(@tag)
    add_breadcrumb "Edit"
  end

  def update
    fetch_tag

    add_breadcrumb @tag.name, edit_tag_path(@tag)
    add_breadcrumb "Edit"

    if @tag.update_attributes(params[:tag])
      flash[:success] = t(:tag_updated)
      redirect_to tags_path
    else
      render 'edit'
    end
  end

  def destroy
    if fetch_tag.destroy
      flash[:success] = t(:tag_deleted)
    else
      flash[:error] = t(:tag_deleted_error) + ": #{@tag.errors[:base].first}"
    end

    redirect_to tags_url
  end

  private # ----------------------------------------------------------

  def fetch_tag
    @tag = Tag.find(params[:id])
  end

  def fetch_tags
    @tags = Tag.paginate(page: params[:page])
    @total = @tags.total_entries
  end
end
