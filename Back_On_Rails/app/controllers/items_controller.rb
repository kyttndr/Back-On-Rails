class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    @item.user = current_user
  end

  def create
    @item = Item.new(allowed_params)
    @item.user = current_user
    if @item.save
      flash[:notice] = "Thank you for register!"
      redirect_to item_path(@item)
    else
      flash[:alert] = "Invalid Form!"
      render :new
    end
  end

  def show
      get_all_item_borrowers
  end

  def edit
  end

  def update
    if @item.update(allowed_params)
      flash[:notice] = "Successfully updated"
      redirect_to item_path(@item)
    else
      render 'edit'
    end
  end

  def destroy
      @item.destroy
      flash[:notice] = "Deleted"
      redirect_to items_path
  end


  def search_items

  end

  def search
    if params[:search_item]
      @item_by_name = Item.where('name LIKE ?', "%#{params[:search_item]}%")
      @item_by_description = Item.where('description LIKE ?', "%#{params[:search_item]}%")
      @items = (@item_by_name + @item_by_description).uniq
    else
    end
    render 'search_items'
  end

  private

  def allowed_params
    params.require(:item).permit(:name, :description, {item_pictures: []})
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def require_user
    if !logged_in?
      flash[:danger] = "you need to log in"
      redirect_to items_path
    end
  end

  def require_same_user
    if current_user != @item.user
      flash[:danger] = "you can only edit or delete your own items"
      redirect_to items_path
    end
  end

    # Returns a list of every user_id that has borrowed the item
    def get_all_item_borrowers
        @all_item_borrowers = Array.new
        item_transactions = @item.transactions
        item_transactions.each do |transaction|
            if(transaction.isApproved == 1 && transaction.isReturned == 1)
                @all_item_borrowers << transaction.borrower
            end
        end
        return @all_item_borrowers
    end

end
