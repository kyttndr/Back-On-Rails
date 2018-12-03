class TagsController < ApplicationController
  before_action :set_tag, only: [:edit, :update, :show]
  before_action :require_admin, only: [:new, :edit]
  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(allowed_params)
    if @tag.save
      flash[:notice] = "a new tag"
    else
      render 'new'
    end
    redirect_to tags_path
  end

  def index
    @tags = Tag.paginate(page: params[:page], per_page: 5)
  end

  def show
    @tag_items = @tag.items.paginate(page: params[:page], per_page: 5)
  end

  def edit

  end

  def update
    if @tag.update(allowed_params)
      flash[:notice] = "Successfully updated"
      redirect_to tag_path(@tag)
    else
      render 'edit'
    end
  end


  private

  def allowed_params
    params.require(:tag).permit(:name)
  end

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def require_admin
    if !logged_in? || current_user.admin == false
      flash[:danger] = "you have no permission"
      redirect_to tags_path
    end
  end

end