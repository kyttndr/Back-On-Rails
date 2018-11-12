class TransactionsController < ApplicationController

    before_action :set_user
    before_action :set_item, only: [:new, :create]
    before_action :get_borrow_transactions, only: [:borrow_index, :pending_index, :borrow_history_index]
    before_action :get_lend_transactions, only: [:lend_index, :pending_index, :lend_history_index]

    def index
    end

    def borrow_index
        #collection of borrow transactions
        @current_borrow_transactions = getCurrentTransactions(@borrow_transactions)
        @future_borrow_transactions = getFutureTransactions(@borrow_transactions)
    end

    def lend_index
        #collection of lend transactions
        @current_lend_transactions = getCurrentTransactions(@lend_transactions)
        @future_lend_transactions = getFutureTransactions(@lend_transactions)
    end

    def pending_index
        @transaction = Transaction.new
        #collection of pending borrow transactions
        @pending_borrow_transactions = getPendingTransactions(@borrow_transactions)
        #collection of pending lend transactions
        @pending_lend_transactions = getPendingTransactions(@lend_transactions)
    end

    def borrow_history_index
        #collection of completed borrow transactions
        @completed_borrow_transactions = getCompletedTransactions(@borrow_transactions)
    end

    def lend_history_index
        #collection of completed lend transactions
        @completed_lend_transactions = getCompletedTransactions(@lend_transactions)
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
            flash[:notice] = "You have requested to borrow the item"
            redirect_to items_path
        else
            flash[:alert] = "Invalid Form!"
            render :new
        end
    end

    def show
        redirect_to root_path
    end

    def edit
        @transaction = Transaction.find(params[:id])
    end

    def update
        @transaction = Transaction.find(params[:id])
        #assign_attributes will only assign to model attributes if it exists in request_params hash
        @transaction.assign_attributes(request_params)
        isSaved = @transaction.save
        if(isSaved)
            flash[:notice] = "You have updated the transaction"
            redirect_to params[:transaction][:redirect]
        else
            flash[:alert] = "Invalid Form!"
            if params[:transaction][:render] == 'pending_index'
                get_borrow_transactions
                get_lend_transactions
                @pending_borrow_transactions = getPendingTransactions(@borrow_transactions)
                @pending_lend_transactions = getPendingTransactions(@lend_transactions)
            end
            render params[:transaction][:render]
            #prev = Rails.application.routes.recognize_path(request.referrer)
            #render prev[:action]
        end
    end

    def destroy
        @transaction = Transaction.find(params[:id])
        @transaction.destroy
        flash[:notice] = "Deleted Transaction"
        redirect_to params[:transaction][:redirect]
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

        def set_user
            @user = current_user
        end

        def set_item
            @item = Item.find(params[:item_id])
        end

        def get_borrow_transactions
            @borrow_transactions = @user.borrow_transactions
        end

        def get_lend_transactions
            @lend_transactions = @user.lend_transactions
        end

        # Returns a collection of all current transactions that
        # 1) is approved
        # 2) is not returned
        def getCurrentTransactions(transactions)
            current_transactions = Array.new
            transactions.each do |transaction|
                if(transaction.isApproved==1 && transaction.isReturned==0 &&
                    Date.current >= transaction.start_date)
                    current_transactions << transaction
                end
            end
            return current_transactions
        end

        # Returns a collection of all future transactions that
        # 1) is approved
        def getFutureTransactions(transactions)
            future_transactions = Array.new
            transactions.each do |transaction|
                if(transaction.isApproved==1 &&
                    Date.current < transaction.start_date)
                    future_transactions << transaction
                end
            end
            return future_transactions
        end

        # Returns a collection of all transactions that
        # 1) is approved
        # 2) is returned
        def getCompletedTransactions(transactions)
            completed_transactions = Array.new
            transactions.each do |transaction|
                if(transaction.isApproved==1 && transaction.isReturned==1)
                    completed_transactions << transaction
                end
            end
            return completed_transactions
        end

        # Returns a collection of all transactions that
        # 1) is not approved
        def getPendingTransactions(transactions)
            pending_transactions = Array.new
            transactions.each do |transaction|
                if(transaction.isApproved==0)
                    pending_transactions << transaction
                end
            end
            return pending_transactions
        end

end
