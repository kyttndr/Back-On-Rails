class BorrowsController < ApplicationController

    before_action :set_item_and_user, only: [:new, :create]


    def index
    end

    def new
        @borrow = Borrow.new
    end

    def create
        @borrow = Borrow.new
        @borrow.borrower = @user
        @borrow.item = @item
        @borrow.lender = @item.user
        @borrow.start_date = params[:borrow][:start_date]
        @borrow.end_date = params[:borrow][:end_date]
        @borrow.isReturned = 0
        isSaved = @borrow.save
        if(isSaved)
            flash[:notice] = "You have borrowed the item"
            redirect_to items_path
        else
            flash[:alert] = "Invalid Form!"
            render :new
        end
    end

    def show
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private
        def allowed_params
          #params.require(:item).permit(:name, :description)
        end

        def set_item_and_user
          @item = Item.find(params[:item_id])
          @user = current_user
        end


end
