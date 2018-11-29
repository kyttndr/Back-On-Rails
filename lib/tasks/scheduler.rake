desc "This task is called by the Heroku scheduler add-on"
task :send_overdue_notification => :environment do
    puts "Sending notifications..."

    Transaction.all.each do |transaction|
        # ITEM IS NOT RETURNED AND IS OVERDUE
        if transaction.isReturned == 0 && transaction.end_date < Date.current
            send_notification('transaction', 'overdue_item', transaction.lender, transaction.borrower, transaction, nil)
            #UserMailer.overdue_item(transaction.borrower, transaction.lender, transaction).deliver
        end
    end


    puts "done."
end

def send_notification(type, tag, source_user, dest_user, subject1, subject2)
    Notification.create do |notification|
        notification.notify_type = type
        notification.tag = tag
        notification.actor = source_user
        notification.user = dest_user
        notification.target = subject1
        notification.second_target = subject2
    end
end
