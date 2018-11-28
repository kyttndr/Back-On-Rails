class UserMailer < ApplicationMailer
    default from: "BackOnRails@gmail.com"

    def new_borrow_request(transaction)
        @transaction = transaction
        @to_user = transaction.lender
        @from_user = transaction.borrower
        @item = transaction.item
        mail to: @to_user.email, subject: "You recieved a new request to borrow '#{@item.name}'"
    end

    def cancelled_request(to_user, from_user, transaction)
        @transaction = transaction
        @to_user = to_user
        @from_user = from_user
        @item = transaction.item
        mail to: @to_user.email, subject: "#{@from_user.username} has cancelled your transaction on '#{@item.name}'"
    end

    def accepted_request(to_user, from_user, transaction)
        @transaction = transaction
        @to_user = to_user
        @from_user = from_user
        @item = transaction.item
        mail to: @to_user.email, subject: "#{@from_user.username} has accepted your request to borrow '#{@item.name}'"
    end

    def reminder_item_due_date

    end

    def overdue_item

    end

    def account_activation(user)
        @user = user
        mail to: user.email, subject: "Account activation"
    end

end
