class TransactionsController < ApplicationController

    before_action :set_item_and_user, only: [:new, :create]


    def index
        @user = User.find(params[:user_id])

        #collection of borrow transactions
        @borrow_transactions = @user.borrow_transactions
        #collection of lend transactions
        @lend_transactions = @user.lend_transactions
    end

    def pending_transactions_index
        @user = User.find(params[:user_id])

        #collection of borrow transactions
        @borrow_transactions = @user.borrow_transactions
        #collection of lend transactions
        @lend_transactions = @user.lend_transactions
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
        @transaction.isApproved = 0
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
        @user = User.find(params[:user_id])
        @transaction = Transaction.find(params[:id])
        #assign_attributes will only assign to model attributes if it exists in request_params hash
        @transaction.assign_attributes(request_params)
        @transaction.save
        redirect_to user_pending_transactions_path(@user)
    end

    def destroy
    end

    private
        def request_params
            params.require(:transaction).permit(:borrower,
                                                :lender,
                                                :item,
                                                :start_date,
                                                :end_date,
                                                :isReturned,
                                                :isApproved)
        end

        def set_item_and_user
          @item = Item.find(params[:item_id])
          @user = current_user
        end


end
