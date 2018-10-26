class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    #user in item will be implemented correctly when session is implemented
    @item.user = User.first
  end

  def create
    @item = Item.new(allowed_params)
    #user in item will be implemented correctly when session is implemented
    @item.user = User.first
    if @item.save
      flash[:notice] = "Thank you for register!"
      redirect_to item_path(@item)
    else
      flash[:alert] = "Invalid Form!"
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(allowed_params)
      flash[:notice] = "Successfully updated"
      redirect_to item_path(@item)
    else
      render 'edit'
    end
  end

  def destroy
    @item = Item.find(params[:id])
      @item.destroy
      flash[:notice] = "Deleted"
      redirect_to items_path
  end
  
  private
  
  def allowed_params
    params.require(:item).permit(:name, :description)
  end
  
end
