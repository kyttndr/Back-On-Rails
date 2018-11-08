class TransactionsController < ApplicationController

    before_action :set_item_and_user, only: [:new, :create]


    def index
    end

    def new
        @transaction = Transaction.new
    end

    def create
        @transaction = Transaction.new
        @transaction.borrower = @user
        @transaction.item = @item
        @transaction.lender = @item.user
        @transaction.start_date = params[:transaction][:start_date]
        @transaction.end_date = params[:transaction][:end_date]
        @transaction.isReturned = 0
        isSaved = @transaction.save
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
